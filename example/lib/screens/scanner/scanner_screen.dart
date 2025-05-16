import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:basf_flutter_components_example/main.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {

  bool isBig = false;
  bool isCooldownMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          openNewPageButton(context),
          bottomSheetButton(),
          cameraSizeButton(),
          cameraCooldownMode(),
          cameraIconButton(),
        ],
      ),
      body: Column(
        spacing: 10,
        children: [
          if (!isCooldownMode) AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: MediaQuery.sizeOf(context).height * (isBig ? 0.4 : 0.2),
            child: Scanner(
              routeObserver: routeObserver,
              onScan: (barcode) {
                AppSnackBar.info(message: barcode).show(context);
              },
            ),
          ),
          if (isCooldownMode) AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: MediaQuery.sizeOf(context).height * (isBig ? 0.4 : 0.2),
            child: Scanner(
              cooldownSeconds: 2,
              routeObserver: routeObserver,
              overlay: UnitsScannerOverlay(
                nextScanText: 'SSCC',
                topLayout: topLayoutSecondScanner(context),
              ),
              onScan: print,
            ),
          ),
        ],
      ),
    );
  }

  Widget topLayoutSecondScanner(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ToggleDirectionIconButton(size: 20),
        Text(
          '700090897979979',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
          ),
        ),
        SizedBox(
          width: 50,
          height: 30,
          child: Assets.rive.emoji.rive(artboard: RiveEmoji.smiling.artBoard),
        ),
      ],
    );
  }

  Widget cameraIconButton() {
    return BlocBuilder<ScannerCubit, ScannerState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            final cubit = context.read<ScannerCubit>();
            switch(state) {
              case ScannerEnabled(): cubit.disableCamera();
              case ScannerDisabled(): cubit.enableCamera();
            }
          },
          icon: switch(state) {
            ScannerEnabled() => const Icon(Icons.camera_alt),
            ScannerDisabled() => const Icon(Icons.no_photography),
          },
        );
      },
    );
  }

  Widget cameraSizeButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          isBig = !isBig;
        });
      },
      icon: Icon(isBig
          ? Icons.photo_size_select_large
          : Icons.photo_size_select_small,
      ),
    );
  }

  Widget cameraCooldownMode() {
    return IconButton(
      onPressed: () {
        setState(() {
          isCooldownMode = !isCooldownMode;
        });
      },
      icon: Icon(isCooldownMode
          ? Icons.timer_outlined
          : Icons.timer_off_outlined,
      ),
    );
  }

  Widget bottomSheetButton() {
    return IconButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          builder: (context) {
            return const Center(child: Text('Scanner must be auto closed'));
          },
        );
      },
      icon: const Icon(Icons.open_in_browser),
    );
  }

  Widget openNewPageButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<Widget>(builder: (context) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Scanner must be auto deactivated')),
            );
          },),
        );
      },
      icon: const Icon(Icons.mobile_screen_share),
    );
  }
}
