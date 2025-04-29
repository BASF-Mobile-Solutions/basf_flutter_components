import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

/// Home tile
class HomeTile extends StatelessWidget {
  /// Home tile
  const HomeTile({
    required this.titleText,
    required this.description,
    required this.leadingImage,
    required this.onPressed,
    this.appBarTitleText,
    this.route,
    this.favoriteData,
    this.borderRadius = 0,
    this.blocProviders = const [],
    this.unfinishedProcessNotification,
    super.key,
  });

  ///
  final String titleText;

  ///
  final String? appBarTitleText;

  ///
  final String description;

  ///
  final String leadingImage;

  /// Mostly used as an id
  final AppRoute? route;

  ///
  final List<BlocProvider> blocProviders;

  ///
  final VoidCallback onPressed;

  ///
  final double borderRadius;

  ///
  final Widget? unfinishedProcessNotification;

  ///
  final FavoriteData? favoriteData;

  double get _height => 122;

  @override
  Widget build(BuildContext context) {
    if (blocProviders.isNotEmpty) {
      return MultiBlocProvider(
        providers: blocProviders,
        child: Builder(builder: layout),
      );
    } else {
      return layout(context);
    }
  }

  ///
  Widget layout(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: _height,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [BasfShadows.smallShadow],
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(children: [image(), Expanded(child: _body())]),
        ),
        BasfTextButton.contained(
          size: Size(double.maxFinite, _height),
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
        ),
        if (favoriteData != null)
          Positioned(
            top: -2.6,
            right: -5,
            child: FavoriteButton(favoriteData: favoriteData!),
          ),
      ],
    );
  }

  ///
  Widget image() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(borderRadius),
        topLeft: Radius.circular(borderRadius),
      ),
      child: FadeInImage(
        height: _height,
        width: 112,
        fadeInDuration: const Duration(milliseconds: 250),
        placeholder: MemoryImage(kTransparentImage),
        image: AssetImage(leadingImage),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _body() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.paddingMediumSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: title(context)),
                      const SizedBox(width: 15),
                    ],
                  ),
                  VerticalSpacer.normal(),
                  Expanded(child: descriptionText(context)),
                ],
              ),
            ),
            if (unfinishedProcessNotification != null)
              unfinishedProcessNotification!,
          ],
        );
      },
    );
  }

  ///
  Widget title(BuildContext context) {
    return Text(
      titleText,
      maxLines: 2,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: BasfColors.black,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  ///
  Widget descriptionText(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(
        color: BasfColors.darkGrey,
        letterSpacing: 0.32,
        height: 1.35,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 3,
    );
  }
}
