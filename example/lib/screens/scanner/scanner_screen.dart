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
          openPageViewExampleButton(context),
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

  Widget openPageViewExampleButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.view_carousel_outlined),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const _ScannerPageViewExampleScreen(),
          ),
        );
      },
    );
  }

  Widget openNewPageWithScannerButton(BuildContext context) {
    Widget screenLayout(int id) {
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
            style: TextButton.styleFrom(
              minimumSize: const Size(double.infinity, 53),
            ),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<Widget>(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => ScannerCubit(id: 'scanner_${id+1}'),
                      child: screenLayout(id + 1),
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
                create: (context) => ScannerCubit(id: 'scanner_id_0'),
                child: screenLayout(1),
              );
            },
          ),
        );
      },
    );
  }
}

class _ScannerPageViewExampleScreen extends StatefulWidget {
  const _ScannerPageViewExampleScreen();

  @override
  State<_ScannerPageViewExampleScreen> createState() =>
      _ScannerPageViewExampleScreenState();
}

class _ScannerPageViewExampleScreenState
    extends State<_ScannerPageViewExampleScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner PageView')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Use this screen to test PageView visibility. Page 2 starts with '
              'camera on, page 3 has no scanner at all.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                _ScannerPageViewInfoPage(),
                _ScannerPageViewScannerPage(
                  scannerId: 'scanner_page_view_2',
                  title: 'Page 2',
                  subtitle: 'Starts with camera enabled.',
                ),
                _ScannerPageViewNoScannerPage(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _currentPage == 0
                        ? null
                        : () => _pageController.previousPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                          ),
                    child: const Text('Previous'),
                  ),
                ),
                Text('Page ${_currentPage + 1}/3'),
                Expanded(
                  child: TextButton(
                    onPressed: _currentPage == 2
                        ? null
                        : () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                          ),
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerPageViewInfoPage extends StatelessWidget {
  const _ScannerPageViewInfoPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Icon(
              Icons.swipe_outlined,
              size: 42,
              color: Theme.of(context).primaryColor,
            ),
            Text('Page 1', style: Theme.of(context).textTheme.headlineSmall),
            const Text(
              'Swipe to pages 2 and 3, toggle the camera there, then move '
              'between pages to verify that an off-screen scanner stops fully.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerPageViewScannerPage extends StatelessWidget {
  const _ScannerPageViewScannerPage({
    required this.scannerId,
    required this.title,
    required this.subtitle,
  });

  final String scannerId;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScannerCubit(id: scannerId),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Text(subtitle, textAlign: TextAlign.center),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: SizedBox(
                    width: double.infinity,
                    height: 320,
                    child: Scanner(
                      routeObserver: routeObserver,
                      overlay: const OnOffStandardScannerOverlay(),
                      onScan: (barcode) {
                        AppSnackBar.info(message: barcode).show(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerPageViewNoScannerPage extends StatelessWidget {
  const _ScannerPageViewNoScannerPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Icon(
              Icons.no_photography_outlined,
              size: 42,
              color: Theme.of(context).primaryColor,
            ),
            Text('Page 3', style: Theme.of(context).textTheme.headlineSmall),
            const Text(
              'This page intentionally has no scanner. It is useful for '
              'verifying that the camera from page 2 stops as soon as the '
              'scanner leaves the viewport.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
