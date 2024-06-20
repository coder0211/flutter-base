import 'package:flutter/material.dart';

class Controller<T> extends ValueNotifier<T> {
  Controller({required T initValue}) : super(initValue);
}

class ControllerWidget<T> extends StatelessWidget {
  final Controller<T> controller;
  final Function(T value) builder;
  const ControllerWidget({
    Key? key,
    required this.controller,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: controller,
      builder: (BuildContext insContext, T value, _) {
        return builder(value);
      },
    );
  }
}
