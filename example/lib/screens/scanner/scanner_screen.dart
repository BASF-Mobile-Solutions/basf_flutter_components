import 'package:basf_flutter_components/basf_flutter_components.dart';
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
          openNewPageWithScannerButton(context),
          openNewPageButton(context),
          scannerBottomSheetButton(),
          bottomSheetButton(),
          cameraSizeButton(),
          cameraCooldownMode(),
          cameraIconButton(),
        ],
      ),
      body: Column(
        spacing: 10,
        children: [
          if (!isCooldownMode)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: MediaQuery.sizeOf(context).height * (isBig ? 0.4 : 0.2),
              child: Scanner(
                routeObserver: routeObserver,
                onScan: (barcode) {
                  AppSnackBar.info(message: barcode).show(context);
                },
              ),
            ),
          if (isCooldownMode)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: MediaQuery.sizeOf(context).height * (isBig ? 0.4 : 0.2),
              child: Scanner(
                cooldownSeconds: 3,
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
          style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
        ),
        SizedBox(
          width: 50,
          height: 30,
          child: BasfAssets.rive.emoji.rive(
            artboard: RiveEmoji.smiling.artBoard,
          ),
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
            switch (state) {
              case ScannerEnabled():
                cubit.disableCamera();
              case ScannerDisabled():
                cubit.enableCamera();
            }
          },
          icon: switch (state) {
            ScannerEnabled() => const Icon(Icons.camera_alt),
            ScannerDisabled() => const Icon(Icons.no_photography),
          },
        );
      },
    );
  }

  Widget cameraSizeButton() {
    return IconButton(
      icon: Icon(
        isBig ? Icons.photo_size_select_large : Icons.photo_size_select_small,
      ),
      onPressed: () {
        setState(() {
          isBig = !isBig;
        });
      },
    );
  }

  Widget cameraCooldownMode() {
    return IconButton(
      icon: Icon(
        isCooldownMode ? Icons.timer_outlined : Icons.timer_off_outlined,
      ),
      onPressed: () {
        setState(() {
          isCooldownMode = !isCooldownMode;
        });
      },
    );
  }

  Widget scannerBottomSheetButton() {
    return IconButton(
      icon: const Icon(Icons.add_a_photo_outlined),
      onPressed: () async {
        await showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          builder: (context) {
            return BlocProvider<ScannerCubit>(
              create: (context) => ScannerCubit(id: 'scanner_2'),
              child: Scanner(
                routeObserver: routeObserver,
                overlay: const OnOffStandardScannerOverlay(),
                onScan: print,
              ),
            );
          },
        );
      },
    );
  }

  Widget bottomSheetButton() {
    return IconButton(
      icon: const Icon(Icons.open_in_browser),
      onPressed: () async {
        await showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          builder: (context) {
            return const Center(child: Text('Scanner must be auto closed'));
          },
        );
      },
    );
  }

  Widget openNewPageButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.mobile_screen_share),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: Text('Scanner must be auto deactivated'),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget openNewPageWithScannerButton(BuildContext context) {
    Widget screenLayout() {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SizedBox(
            height: 300,
            child: Scanner(
              onScan: (code) {},
              overlay: const OnOffStandardScannerOverlay(),
              routeObserver: routeObserver,
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(40),
          child: TextButton(
            style: TextButton.styleFrom(minimumSize: const Size(double.infinity, 53)),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<Widget>(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => ScannerCubit(id: 'scanner_3'),
                      child: screenLayout(),
                    );
                  },
                ),
              );
            },
            child: const Text('Next screen'),
          ),
        ),
      );
    }
    return IconButton(
      icon: const Icon(Icons.send_to_mobile),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (context) {
              return BlocProvider(
                create: (context) => ScannerCubit(id: 'scanner_0'),
                child: screenLayout(),
              );
            },
          ),
        );
      },
    );
  }
}
