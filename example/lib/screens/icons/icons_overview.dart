import 'package:basf_flutter_components/basf_flutter_components.dart';
import 'package:flutter/material.dart';

class IconsOverviewScreen extends StatelessWidget {
  const IconsOverviewScreen({super.key});

  static const List<IconData> _icons = [
    BasfIcons.add_circle,
    BasfIcons.add,
    BasfIcons.arrow_back,
    BasfIcons.arrow_backwards_thin,
    BasfIcons.arrow_down,
    BasfIcons.arrow_dropdown_down,
    BasfIcons.arrow_dropdown_up,
    BasfIcons.arrow_forward_thin,
    BasfIcons.arrow_forward,
    BasfIcons.arrow_jump_back,
    BasfIcons.arrow_up,
    BasfIcons.attachment,
    BasfIcons.attention,
    BasfIcons.blog,
    BasfIcons.bookmark,
    BasfIcons.calendar,
    BasfIcons.cart,
    BasfIcons.check_circle,
    BasfIcons.check,
    BasfIcons.close_circle,
    BasfIcons.close,
    BasfIcons.comment,
    BasfIcons.download,
    BasfIcons.edit,
    BasfIcons.eye,
    BasfIcons.facebook,
    BasfIcons.fax,
    BasfIcons.flickr,
    BasfIcons.filter,
    BasfIcons.full_view_end,
    BasfIcons.full_view,
    BasfIcons.google_plus,
    BasfIcons.heart,
    BasfIcons.home,
    BasfIcons.instagram,
    BasfIcons.key,
    BasfIcons.letter,
    BasfIcons.link_circle,
    BasfIcons.linkedin,
    BasfIcons.location,
    BasfIcons.lock_open,
    BasfIcons.lock,
    BasfIcons.menu,
    BasfIcons.messenger,
    BasfIcons.minus_circle,
    BasfIcons.mobile,
    BasfIcons.more_options,
    BasfIcons.movie,
    BasfIcons.new_window,
    BasfIcons.notification,
    BasfIcons.pause_circle,
    BasfIcons.pause,
    BasfIcons.pdf,
    BasfIcons.picture_slideshow,
    BasfIcons.picture,
    BasfIcons.pinterest,
    BasfIcons.print,
    BasfIcons.question,
    BasfIcons.reload,
    BasfIcons.renren,
    BasfIcons.send,
    BasfIcons.search,
    BasfIcons.settings,
    BasfIcons.share,
    BasfIcons.slideshare,
    BasfIcons.star,
    BasfIcons.tap,
    BasfIcons.telephone,
    BasfIcons.time,
    BasfIcons.trash,
    BasfIcons.twitter,
    BasfIcons.upload,
    BasfIcons.user,
    BasfIcons.wechat,
    BasfIcons.weibo,
    BasfIcons.whatsapp,
    BasfIcons.world,
    BasfIcons.xing,
    BasfIcons.youku,
    BasfIcons.youtube,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basf Icons')),
      body: GridView.extent(
        maxCrossAxisExtent: 130,
        children: List.generate(_icons.length, (index) {
          final icon = _icons[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              Text(icon.codePoint.toRadixString(16)),
            ],
          );
        }),
      ),
    );
  }
}
