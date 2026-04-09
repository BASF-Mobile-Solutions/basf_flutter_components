import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:flutter/material.dart' hide Animation;
import 'package:rive/rive.dart';

base class BasfRiveAnimationStateMachineController extends RiveWidgetController {
  BasfRiveAnimationStateMachineController(
    super.file, {
    super.artboardSelector,
    super.stateMachineSelector,
    this.animationNames = const [],
  }) {
    _animations = [
      for (final name in animationNames)
        artboard.animationNamed(name) ??
            (throw RiveArtboardException(
              'Animation with name "$name" not found.',
            )),
    ];
  }

  final List<String> animationNames;
  late final List<Animation> _animations;

  @override
  bool advance(double elapsedSeconds) {
    var didAdvanceAnimations = false;
    for (final animation in _animations) {
      didAdvanceAnimations =
          animation.advanceAndApply(elapsedSeconds) || didAdvanceAnimations;
    }

    final didAdvanceStateMachine = super.advance(elapsedSeconds);
    return active && (didAdvanceAnimations || didAdvanceStateMachine);
  }
}

class BasfRiveAnimationStateMachineAsset extends StatefulWidget {
  const BasfRiveAnimationStateMachineAsset({
    required this.asset,
    required this.animationNames,
    this.artboard,
    this.stateMachine,
    this.fit = Fit.contain,
    this.alignment = Alignment.center,
    this.dataBind,
    this.onLoaded,
    this.loading = const SizedBox.shrink(),
    super.key,
  });

  final RiveGenImage asset;
  final List<String> animationNames;
  final String? artboard;
  final String? stateMachine;
  final Fit fit;
  final Alignment alignment;
  final DataBind? dataBind;
  final void Function(RiveLoaded state)? onLoaded;
  final Widget loading;

  @override
  State<BasfRiveAnimationStateMachineAsset> createState() =>
      _BasfRiveAnimationStateMachineAssetState();
}

class _BasfRiveAnimationStateMachineAssetState
    extends State<BasfRiveAnimationStateMachineAsset> {
  late final Future<bool> _initialization =
      RiveNative.isInitialized ? Future.value(true) : RiveNative.init();
  late final FileLoader _fileLoader = widget.asset.riveFileLoader();

  @override
  void dispose() {
    _fileLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return widget.loading;
        }

        if (snapshot.hasError) {
          return ErrorWidget.withDetails(
            message: 'Failed to initialize Rive Native.',
            error: FlutterError(snapshot.error.toString()),
          );
        }

        return RiveWidgetBuilder(
          fileLoader: _fileLoader,
          artboardSelector: widget.artboard == null
              ? ArtboardSelector.byDefault()
              : ArtboardSelector.byName(widget.artboard!),
          stateMachineSelector: widget.stateMachine == null
              ? StateMachineSelector.byDefault()
              : StateMachineSelector.byName(widget.stateMachine!),
          dataBind: widget.dataBind,
          controller: (file) => BasfRiveAnimationStateMachineController(
            file,
            artboardSelector: widget.artboard == null
                ? ArtboardSelector.byDefault()
                : ArtboardSelector.byName(widget.artboard!),
            stateMachineSelector: widget.stateMachine == null
                ? StateMachineSelector.byDefault()
                : StateMachineSelector.byName(widget.stateMachine!),
            animationNames: widget.animationNames,
          ),
          onLoaded: widget.onLoaded,
          builder: (context, state) => switch (state) {
            RiveLoading() => widget.loading,
            RiveFailed() => ErrorWidget.withDetails(
                message: 'Failed to load Rive asset.',
                error: FlutterError(state.error.toString()),
              ),
            RiveLoaded() => RiveWidget(
                controller: state.controller,
                fit: widget.fit,
                alignment: widget.alignment,
              ),
          },
        );
      },
    );
  }
}

class BasfRiveArtboardAsset extends StatefulWidget {
  const BasfRiveArtboardAsset({
    required this.asset,
    this.artboard,
    this.stateMachine,
    this.fit = Fit.contain,
    this.alignment = Alignment.center,
    this.loading = const SizedBox.shrink(),
    super.key,
  });

  final RiveGenImage asset;
  final String? artboard;
  final String? stateMachine;
  final Fit fit;
  final Alignment alignment;
  final Widget loading;

  @override
  State<BasfRiveArtboardAsset> createState() => _BasfRiveArtboardAssetState();
}

class _BasfRiveArtboardAssetState extends State<BasfRiveArtboardAsset> {
  late final Future<bool> _initialization =
      RiveNative.isInitialized ? Future.value(true) : RiveNative.init();
  late final FileLoader _fileLoader = widget.asset.riveFileLoader();
  late final StateMachinePainter _painter = StateMachinePainter(
    stateMachineName: widget.stateMachine,
    fit: widget.fit,
    alignment: widget.alignment,
  );
  late final Future<File> _fileFuture = _loadFile();

  File? _loadedFile;

  Future<File> _loadFile() async {
    await _initialization;
    final file = await _fileLoader.file();
    _loadedFile = file;
    return file;
  }

  @override
  void dispose() {
    _painter.dispose();
    _loadedFile?.dispose();
    _fileLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _fileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return widget.loading;
        }

        if (snapshot.hasError) {
          return ErrorWidget.withDetails(
            message: 'Failed to load Rive asset.',
            error: FlutterError(snapshot.error.toString()),
          );
        }

        final file = snapshot.data;
        if (file == null) {
          return const SizedBox.shrink();
        }

        final artboard = widget.artboard == null
            ? file.defaultArtboard()
            : file.artboard(widget.artboard!);
        if (artboard == null) {
          return ErrorWidget.withDetails(
            message: 'Unable to load Rive artboard: "${widget.artboard}".',
            error: FlutterError(
              'Unable to load artboard: ${widget.artboard}',
            ),
          );
        }

        return RiveArtboardWidget(
          artboard: artboard,
          painter: _painter,
        );
      },
    );
  }
}

class BasfRiveAnimationAsset extends StatefulWidget {
  const BasfRiveAnimationAsset({
    required this.asset,
    required this.animationName,
    this.artboard,
    this.fit = Fit.contain,
    this.alignment = Alignment.center,
    this.loading = const SizedBox.shrink(),
    super.key,
  });

  final RiveGenImage asset;
  final String animationName;
  final String? artboard;
  final Fit fit;
  final Alignment alignment;
  final Widget loading;

  @override
  State<BasfRiveAnimationAsset> createState() => _BasfRiveAnimationAssetState();
}

class _BasfRiveAnimationAssetState extends State<BasfRiveAnimationAsset> {
  late final Future<bool> _initialization =
      RiveNative.isInitialized ? Future.value(true) : RiveNative.init();
  late final FileLoader _fileLoader = widget.asset.riveFileLoader();
  late final SingleAnimationPainter _painter = SingleAnimationPainter(
    widget.animationName,
    fit: widget.fit,
    alignment: widget.alignment,
  );
  late final Future<File> _fileFuture = _loadFile();

  File? _loadedFile;

  Future<File> _loadFile() async {
    await _initialization;
    final file = await _fileLoader.file();
    _loadedFile = file;
    return file;
  }

  @override
  void dispose() {
    _painter.dispose();
    _loadedFile?.dispose();
    _fileLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _fileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return widget.loading;
        }

        if (snapshot.hasError) {
          return ErrorWidget.withDetails(
            message: 'Failed to load Rive asset.',
            error: FlutterError(snapshot.error.toString()),
          );
        }

        final file = snapshot.data;
        if (file == null) {
          return const SizedBox.shrink();
        }

        final artboard = widget.artboard == null
            ? file.defaultArtboard()
            : file.artboard(widget.artboard!);
        if (artboard == null) {
          return ErrorWidget.withDetails(
            message: 'Unable to load Rive artboard: "${widget.artboard}".',
            error: FlutterError(
              'Unable to load artboard: ${widget.artboard}',
            ),
          );
        }

        return RiveArtboardWidget(
          artboard: artboard,
          painter: _painter,
        );
      },
    );
  }
}
