import 'package:flutter/material.dart';
import 'package:improve_base/utils/debounce.dart';
import 'package:improve_base/widgets/null_widget.dart';

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
          if (widget.child != null) widget.child ?? nullWidget,
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
    if ([AxisDirection.down, AxisDirection.up].contains(notification.metrics.axisDirection)) {
      isShowBottomBar.value = false;
      Debounce(milliseconds: 1000).run(() => isShowBottomBar.value = true);
    } else {
      isShowBottomBar.value = true;
    }
    return true;
  }
}
