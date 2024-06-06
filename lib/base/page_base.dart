import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improve_base/utils/app_utils.dart';
import 'package:improve_base/widgets/loading_dialog.dart';

abstract class PageBase extends StatefulWidget {
  const PageBase({Key? key}) : super(key: key);
}

abstract class PageBaseStateWithCubit<T extends PageBase, C extends Cubit> extends State<T>
    with AutomaticKeepAliveClientMixin<T> {
  /// variables

  late C cubit;

  bool shouldPop = true;

  /// initCubit
  /// handle initial cubit state
  C initCubit();

  Widget buildContent(BuildContext context);

  @override
  void initState() {
    super.initState();
    cubit = initCubit();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async => shouldPop,
      child: GestureDetector(
        onTap: () => AppUtils.hideKeyboard(context),
        child: buildContent(context),
      ),
    );
  }

  ///[wantKeepAlive] is a flag to keep the screen alive.
  @override
  bool get wantKeepAlive => true;
}

abstract class PageBaseState<T extends PageBase> extends State<T> with AutomaticKeepAliveClientMixin<T> {
  bool shouldPop = true;

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async => shouldPop,
      child: GestureDetector(
        onTap: () => AppUtils.hideKeyboard(context),
        child: buildContent(context),
      ),
    );
  }

  ///[wantKeepAlive] is a flag to keep the screen alive.
  @override
  bool get wantKeepAlive => true;
}

mixin PageLoadingMixin {
  final LoadingDialog _loadingDialog = LoadingDialog();

  void showLoading(BuildContext context) {
    _loadingDialog.show(context);
  }

  void hideLoading(BuildContext context) {
    _loadingDialog.hide(context);
  }
}
