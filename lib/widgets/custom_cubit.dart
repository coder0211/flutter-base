import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improve_base/equatable/equatable.dart';

class CustomCubit<T extends Equatable> extends Cubit<T> {
  CustomCubit(super.initialState);

  @override
  void emit(state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
