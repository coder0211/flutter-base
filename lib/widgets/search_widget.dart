import 'package:flutter/material.dart';
import 'package:improve_base/utils/debounce.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController tfController;
  final Function(String q) onSearch;
  final String? hintText;
  final int timeTypingDelay;

  /// The func is search rule
  /// - true: if the keyword passed rule
  /// - false: if the keyword not passed rule
  final bool Function(String q) searchRule;

  const SearchWidget({
    Key? key,
    required this.tfController,
    required this.onSearch,
    required this.searchRule,
    this.hintText = '',
    this.timeTypingDelay = 1000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: improve UI for this widget
    return TextField(
      controller: tfController,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  void onChanged(String value) {
    if (!searchRule(value)) return;

    Debounce(milliseconds: timeTypingDelay).run(() {
      onSearch.call(value);
    });
  }
}
