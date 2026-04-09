import 'package:basf_flutter_components/utils/gen/assets.gen.dart';
import 'package:flutter/material.dart' hide Animation;
import 'package:rive/rive.dart';

abstract final class BasfRive {
  static Factory defaultFactory = Factory.flutter;

  static Future<bool> init({
    Factory? defaultFactory,
  }) async {
    BasfRive.defaultFactory = defaultFactory ?? Factory.flutter;
    return RiveNative.isInitialized ? true : RiveNative.init();
  }
}

ArtboardSelector _artboardSelector(String? artboard) => artboard == null
    ? ArtboardSelector.byDefault()
    : ArtboardSelector.byName(artboard);

StateMachineSelector _stateMachineSelector(String? stateMachine) =>
    stateMachine == null
        ? StateMachineSelector.byDefault()
        : StateMachineSelector.byName(stateMachine);

ErrorWidget _riveErrorWidget(String message, Object error) {
  return ErrorWidget.withDetails(
    message: message,
    error: FlutterError(error.toString()),
  );
}

Artboard? _artboardFromFile(File file, String? artboard) => artboard == null
    ? file.defaultArtboard()
    : file.artboard(artboard);

base class _BasfRiveAnimationStateMachineController extends RiveWidgetController {
  _BasfRiveAnimationStateMachineController(
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
    this.animationNames = const [],
    this.factory,
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
  final Factory? factory;
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
  late FileLoader _fileLoader = _createFileLoader();

  FileLoader _createFileLoader() {
    return widget.asset.riveFileLoader(
      factory: widget.factory ?? BasfRive.defaultFactory,
    );
  }

  @override
  void didUpdateWidget(covariant BasfRiveAnimationStateMachineAsset oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asset.keyName != widget.asset.keyName ||
        oldWidget.factory != widget.factory) {
      _fileLoader.dispose();
      _fileLoader = _createFileLoader();
    }
  }

  @override
  void dispose() {
    _fileLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final artboardSelector = _artboardSelector(widget.artboard);
    final stateMachineSelector = _stateMachineSelector(widget.stateMachine);

    return FutureBuilder<bool>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return widget.loading;
        }

        if (snapshot.hasError) {
          return _riveErrorWidget(
            'Failed to initialize Rive Native.',
            snapshot.error ?? 'Unknown Rive initialization error.',
          );
        }

        return RiveWidgetBuilder(
          fileLoader: _fileLoader,
          artboardSelector: artboardSelector,
          stateMachineSelector: stateMachineSelector,
          dataBind: widget.dataBind,
          controller: (file) => _BasfRiveAnimationStateMachineController(
            file,
            artboardSelector: artboardSelector,
            stateMachineSelector: stateMachineSelector,
            animationNames: widget.animationNames,
          ),
          onLoaded: widget.onLoaded,
          builder: (context, state) => switch (state) {
            RiveLoading() => widget.loading,
            RiveFailed() => _riveErrorWidget(
                'Failed to load Rive asset.',
                state.error,
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

class BasfRiveAnimationAsset extends StatefulWidget {
  const BasfRiveAnimationAsset({
    required this.asset,
    required this.animationName,
    this.factory,
    this.artboard,
    this.fit = Fit.contain,
    this.alignment = Alignment.center,
    this.loading = const SizedBox.shrink(),
    super.key,
  });

  final RiveGenImage asset;
  final String animationName;
  final Factory? factory;
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
  late FileLoader _fileLoader = _createFileLoader();
  late SingleAnimationPainter _painter = _createPainter();
  late Future<File> _fileFuture = _loadFile();

  File? _loadedFile;

  FileLoader _createFileLoader() {
    return widget.asset.riveFileLoader(
      factory: widget.factory ?? BasfRive.defaultFactory,
    );
  }

  SingleAnimationPainter _createPainter() {
    return SingleAnimationPainter(
      widget.animationName,
      fit: widget.fit,
      alignment: widget.alignment,
    );
  }

  Future<File> _loadFile() async {
    await _initialization;
    final file = await _fileLoader.file();
    _loadedFile = file;
    return file;
  }

  @override
  void didUpdateWidget(covariant BasfRiveAnimationAsset oldWidget) {
    super.didUpdateWidget(oldWidget);

    var shouldRebuild = false;

    if (oldWidget.animationName != widget.animationName ||
        oldWidget.fit != widget.fit ||
        oldWidget.alignment != widget.alignment) {
      _painter.dispose();
      _painter = _createPainter();
      shouldRebuild = true;
    }

    if (oldWidget.asset.keyName != widget.asset.keyName ||
        oldWidget.factory != widget.factory) {
      _loadedFile?.dispose();
      _loadedFile = null;
      _fileLoader.dispose();
      _fileLoader = _createFileLoader();
      _fileFuture = _loadFile();
      shouldRebuild = true;
    }

    if (shouldRebuild) {
      setState(() {});
    }
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
          return _riveErrorWidget(
            'Failed to load Rive asset.',
            snapshot.error ?? 'Unknown Rive loading error.',
          );
        }

        final file = snapshot.data;
        if (file == null) {
          return const SizedBox.shrink();
        }

        final artboard = _artboardFromFile(file, widget.artboard);
        if (artboard == null) {
          return _riveErrorWidget(
            'Unable to load Rive artboard: "${widget.artboard}".',
            'Unable to load artboard: ${widget.artboard}',
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
