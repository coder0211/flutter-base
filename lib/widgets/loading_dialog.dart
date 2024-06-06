import 'package:flutter/material.dart';

class LoadingDialog {
  LoadingDialog._();

  static final LoadingDialog instance = LoadingDialog._();

  factory LoadingDialog() {
    return instance;
  }

  bool _isLoading = false;

  void show(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: const Center(
                  child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              )));
        },
      ).then((value) {
        _isLoading = false;
      });
    }
  }

  void hide(BuildContext context) {
    if (_isLoading) {
      _isLoading = false;
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    }
  }
}
