import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improve_base/model/user.dart';

class MainState extends Equatable {
  final List<User> users;

  const MainState({
    this.users = const [],
  });

  // @override
  // String toString() {
  //   return '${users.length}';
  // }

  @override
  List<Object?> get props => [users.hashCode];
}

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void init() {
    emit(MainState(users: [
      User(name: 'Hello 1', description: '1234'),
      User(name: 'Hello 2', description: '12345'),
      User(name: 'Hello 3', description: '123456'),
    ]));
  }

  void change() {
    state.users[1].description = DateTime.now().microsecondsSinceEpoch.toString();
    // state.users.add(User(name: 'asdf', description: DateTime.now().microsecondsSinceEpoch.toString()));
    emit(MainState(users: state.users.toList()));
  }
}
