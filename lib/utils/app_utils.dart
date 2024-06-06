import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppUtils {
  AppUtils._();

  static void hideKeyboard(BuildContext context) => FocusScope.of(context).requestFocus(FocusNode());

  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  static void onWidgetBuildDone(FutureOr onBuildDone) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await onBuildDone;
    });
  }
}
