import 'package:flutter/material.dart';

class SlideSection extends StatefulWidget {
  final Widget child;
  final bool isShow;
  final Offset? startOffset, endOffset;
  const SlideSection({
    Key? key,
    required this.child,
    required this.isShow,
    this.startOffset,
    this.endOffset,
  })  : assert(
          (startOffset != null && endOffset != null) || (startOffset == null && endOffset == null),
        ),
        super(key: key);

  @override
  State<SlideSection> createState() => _SlideSectionState();
}

class _SlideSectionState extends State<SlideSection> with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _animation;

  late Offset begin;
  late Offset end;
  late Cubic curve;
  late Animatable<Offset> tween;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runSlideCheck();
  }

  void prepareAnimations() {
    begin = widget.startOffset ?? const Offset(0.0, 1.0);
    end = widget.endOffset ?? Offset.zero;
    curve = Curves.ease;
    tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _slideController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runSlideCheck() {
    if (widget.isShow) {
      _slideController.forward();
    } else {
      _slideController.reverse();
    }
  }

  @override
  void didUpdateWidget(SlideSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runSlideCheck();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation.drive(tween),
      child: widget.child,
    );
  }
}
