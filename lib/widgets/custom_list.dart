import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget emptyWidget, loadingWidget;
  final int itemCount;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final bool isLoading;
  const CustomList({
    Key? key,
    required this.itemBuilder,
    required this.emptyWidget,
    required this.itemCount,
    required this.isLoading,
    required this.loadingWidget,
    this.shrinkWrap = false,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) return emptyWidget;
    if (isLoading) return loadingWidget;
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }
}
