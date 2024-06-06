import 'package:flutter/material.dart';
import 'package:improve_base/utils/debouncer.dart';

import 'slide_section.dart';

class ScrollHideBottomBar extends StatefulWidget {
  final List<Widget>? children;
  final Widget? child;
  final Widget bottomBar;
  final bool shrinkWrap;
  const ScrollHideBottomBar({
    Key? key,
    this.children,
    required this.bottomBar,
    this.shrinkWrap = false,
    this.child,
  })  : assert((child == null && children != null) || (child != null && children == null)),
        super(key: key);

  @override
  State<ScrollHideBottomBar> createState() => _ScrollHideBottomBarState();
}

class _ScrollHideBottomBarState extends State<ScrollHideBottomBar> {
  ValueNotifier<bool> isShowBottomBar = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (widget.children != null)
            ListView(
              shrinkWrap: widget.shrinkWrap,
              children: widget.children ?? [],
            ),
          ValueListenableBuilder<bool>(
            builder: (_, isShow, __) {
              return SlideSection(
                isShow: isShow,
                child: widget.bottomBar,
              );
            },
            valueListenable: isShowBottomBar,
          ),
        ],
      ),
    );
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification.metrics.pixels > 30) {
      isShowBottomBar.value = false;
      Debouncer(milliseconds: 300).run(() => isShowBottomBar.value = true);
    } else {
      isShowBottomBar.value = true;
    }
    return true;
  }
}
