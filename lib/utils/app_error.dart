import 'package:flutter/material.dart';

enum AppErrorEnum {
  someThingWhenWrong,
}

class AppError {
  AppError(
    this.appErrorEnum, {
    this.content,
  });

  final AppErrorEnum appErrorEnum;
  final String? content;
  late BuildContext context;

  void log(BuildContext context) {
    throw AppError(appErrorEnum, content: content ?? '')..context = context;
  }
}
