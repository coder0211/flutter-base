import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCubit extends Cubit {
  CustomCubit(super.initialState);

  @override
  void emit(state) {
    if (!isClosed) super.emit(state);
  }
}
