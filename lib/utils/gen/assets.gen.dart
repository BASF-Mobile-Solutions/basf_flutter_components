// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart' as _rive;

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/basf_logo.webp
  AssetGenImage get basfLogo =>
      const AssetGenImage('assets/images/basf_logo.webp');

  /// File path: assets/images/checklist_girl.webp
  AssetGenImage get checklistGirl =>
      const AssetGenImage('assets/images/checklist_girl.webp');

  /// List of all assets
  List<AssetGenImage> get values => [basfLogo, checklistGirl];
}

class $AssetsRiveGen {
  const $AssetsRiveGen();

  /// File path: assets/rive/emoji.riv
  RiveGenImage get emoji => const RiveGenImage('assets/rive/emoji.riv');

  /// File path: assets/rive/gears.riv
  RiveGenImage get gears => const RiveGenImage('assets/rive/gears.riv');

  /// File path: assets/rive/logistics_box.riv
  RiveGenImage get logisticsBox =>
      const RiveGenImage('assets/rive/logistics_box.riv');

  /// File path: assets/rive/message_icon.riv
  RiveGenImage get messageIcon =>
      const RiveGenImage('assets/rive/message_icon.riv');

  /// File path: assets/rive/qr.riv
  RiveGenImage get qr => const RiveGenImage('assets/rive/qr.riv');

  /// File path: assets/rive/search_loop.riv
  RiveGenImage get searchLoop =>
      const RiveGenImage('assets/rive/search_loop.riv');

  /// File path: assets/rive/success_icon.riv
  RiveGenImage get successIcon =>
      const RiveGenImage('assets/rive/success_icon.riv');

  /// List of all assets
  List<RiveGenImage> get values => [
    emoji,
    gears,
    logisticsBox,
    messageIcon,
    qr,
    searchLoop,
    successIcon,
  ];
}

class BasfAssets {
  const BasfAssets._();

  static const String package = 'basf_flutter_components';

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsRiveGen rive = $AssetsRiveGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  static const String package = 'basf_flutter_components';

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
  }) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => 'packages/basf_flutter_components/$_assetName';
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class RiveGenImage {
  const RiveGenImage(this._assetName, {this.flavors = const {}});

  final String _assetName;
  final Set<String> flavors;

  static const String package = 'basf_flutter_components';

  _rive.RiveAnimation rive({
    String? artboard,
    List<String> animations = const [],
    List<String> stateMachines = const [],
    BoxFit? fit,
    Alignment? alignment,
    Widget? placeHolder,
    bool antialiasing = true,
    bool useArtboardSize = false,
    List<_rive.RiveAnimationController> controllers = const [],
    _rive.OnInitCallback? onInit,
  }) {
    return _rive.RiveAnimation.asset(
      'packages/basf_flutter_components/$_assetName',
      artboard: artboard,
      animations: animations,
      stateMachines: stateMachines,
      fit: fit,
      alignment: alignment,
      placeHolder: placeHolder,
      antialiasing: antialiasing,
      useArtboardSize: useArtboardSize,
      controllers: controllers,
      onInit: onInit,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/basf_flutter_components/$_assetName';
}
