import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/l10n/localizations/basf_components_localizations.dart';
import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_default_error_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_no_permission_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/layouts/scanner_success_layout.dart';
import 'package:basf_flutter_components/src/widgets/scanner/widgets/scanner_cool_down.dart';
import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

/// !!! Read this to setup camera access https://pub.dev/packages/mobile_scanner
/// !!! Requires [ScannerCubit] to be provided above this widget
/// [HydratedStorage] must also be initialized on app launch
/// Main launch logic for scanner
class Scanner extends StatefulWidget {
  ///
  const Scanner({
    required this.onScan,
    required this.routeObserver,
    this.cooldownSeconds,
    this.overlay = const StandardScannerOverlay(),
    this.offlinePlaceholder,
    super.key,
  });

  /// Scanner window size
  /// Callback for scanned barcode
  final void Function(String) onScan;

  /// Camera does not stop after scan, just pauses for a period
  final int? cooldownSeconds;

  /// Scanner design
  final Widget overlay;

  /// Shows when camera is off
  final Widget? offlinePlaceholder;

  /// Auto closes the scanner when it's not on the top screen in the stack
  final RouteObserver<ModalRoute<void>>? routeObserver;

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> with RouteAware {
  late final ScannerCubit scannerCubit;
  late final ValueNotifier<bool> codeScannedNotifier;
  late final ValueNotifier<bool> coolDownVisibilityNotifier;

  /// To prevent disable/enable cooldown restart when it's active
  DateTime? coolDownEndTime;

  @override
  void initState() {
    super.initState();
    scannerCubit = context.read<ScannerCubit>();
    codeScannedNotifier = ValueNotifier(false);
    coolDownVisibilityNotifier = ValueNotifier(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final obs = widget.routeObserver;
    final route = ModalRoute.of(context);
    if (obs != null && route is PageRoute) obs.subscribe(this, route);
  }

  @override
  Future<void> dispose() async {
    // only unsubscribe if we previously subscribed
    widget.routeObserver?.unsubscribe(this);
    codeScannedNotifier.dispose();
    coolDownVisibilityNotifier.dispose();
    super.dispose();
    await scannerCubit.cameraController.stop();
  }

  @override
  void didPushNext() {
    // we're covered by a new route
    scannerCubit.disableCamera(save: false, automatic: true);
  }

  @override
  void didPopNext() {
    // the covering route went away
    scannerCubit.enableCamera(save: false, automatic: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerCubit, ScannerState>(
      bloc: scannerCubit,
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width =
                constraints.maxWidth.isFinite && constraints.maxWidth > 500
                ? constraints.maxWidth
                : 500.0;
            final height =
                constraints.maxHeight.isFinite && constraints.maxHeight > 170
                ? constraints.maxHeight
                : 170.0;

            return SizedBox(
              width: width,
              height: height,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: switch (state) {
                  ScannerEnabled() => scanner(),
                  ScannerDisabled() =>
                    widget.offlinePlaceholder ?? basfLogo(context),
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget scanner() {
    return ValueListenableBuilder(
      valueListenable: codeScannedNotifier,
      builder: (context, scanned, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: scanned && widget.cooldownSeconds == null
              ? successLayout(context)
              : scannerCamera(context),
        );
      },
    );
  }

  Widget successLayout(BuildContext context) {
    final localizations = BasfComponentsLocalizations.of(context);
    return ScannerSuccessLayout(
      onPressed: () => codeScannedNotifier.value = false,
    );
  }

  Widget scannerCamera(BuildContext context) {
    final localizations = BasfComponentsLocalizations.of(context);
    return MobileScanner(
      controller: scannerCubit.cameraController,
      errorBuilder: (context, error) {
        return switch (error.errorCode) {
          MobileScannerErrorCode.unsupported ||
          MobileScannerErrorCode.controllerAlreadyInitialized
            => const ScannerNoCameraLayout(),
          MobileScannerErrorCode.permissionDenied
            => ScannerNoPermissionLayout(),
          _ => ScannerDefaultErrorLayout(message: error.errorCode.message),
        };
      },
      onDetect: (capture) => onDetect(context, capture),
      overlayBuilder: (context, constrains) {
        return Stack(
          children: [
            widget.overlay,
            if (widget.cooldownSeconds != null) ...[
              Positioned.fill(child: successIcon()),
              Positioned.fill(child: cooldown()),
            ],
          ],
        );
      },
    );
  }

  void onDetect(BuildContext context, BarcodeCapture capture) {
    final valueExists =
        capture.barcodes.isNotEmpty &&
        capture.barcodes.first.rawValue?.isNotEmpty != null;

    if (valueExists) {
      stopCameraAfterScan(context, capture.barcodes.first.rawValue!);
    }
  }

  Future<void> stopCameraAfterScan(BuildContext context, String barcode) async {
    // Continue only if camera is ready for next scan
    if (codeScannedNotifier.value || coolDownVisibilityNotifier.value) return;
    if (mounted) codeScannedNotifier.value = true;

    try {
      widget.onScan(barcode);
      await vibrate(VibrationPreset.singleShortBuzz);

      if (widget.cooldownSeconds == null) {
        await scannerCubit.cameraController.stop();
      } else {
        await enableCooldown();
      }
    } catch (e) {
      final msg = e.toString();
      const duration = Duration(milliseconds: 1700);
      await vibrate(VibrationPreset.doubleBuzz);

      if (context.mounted) {
        AppSnackBar.error(message: msg).show(context, duration: duration);
      }
      if (widget.cooldownSeconds != null) await enableCooldown();
    }
  }

  Future<void> enableCooldown() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        coolDownVisibilityNotifier.value = true;
        coolDownEndTime ??= DateTime.now().add(
          Duration(seconds: widget.cooldownSeconds!),
        );
      }
    });

    // Turn scanning back after cooldown
    await Future.delayed(Duration(seconds: widget.cooldownSeconds!), () {
      if (mounted) {
        codeScannedNotifier.value = false;
        coolDownVisibilityNotifier.value = false;
        coolDownEndTime = null;
      }
    });
  }

  Widget successIcon() {
    return ValueListenableBuilder(
      valueListenable: coolDownVisibilityNotifier,
      builder: (context, cooldownVisible, _) {
        return ValueListenableBuilder(
          valueListenable: codeScannedNotifier,
          builder: (context, scanned, _) {
            return AnimatedOpacity(
              opacity: scanned && !cooldownVisible ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.check,
                size: 60,
                color: BasfColors.white.withValues(alpha: 0.9),
              ),
            );
          },
        );
      },
    );
  }

  Widget cooldown() {
    return ValueListenableBuilder(
      valueListenable: coolDownVisibilityNotifier,
      builder: (context, visible, _) {
        if (visible) {
          return ScannerCoolDown(
            endTime: coolDownEndTime,
            cooldownSeconds: widget.cooldownSeconds ?? 3,
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget basfLogo(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 150, maxHeight: 150),
        child: Assets.images.basfLogo.image(
          fit: BoxFit.contain,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Future<void> vibrate(VibrationPreset preset) async {
    if (await Vibration.hasVibrator()) await Vibration.vibrate(preset: preset);
  }
}
