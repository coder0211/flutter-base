import 'package:improve_base/equatable/equatable.dart';
import 'package:improve_base/model/user.dart';
import 'package:improve_base/widgets/custom_cubit.dart';

class MainState extends Equatable {
  final List<User> users;
  final String userIdSelected;

  MainState({
    this.users = const [],
    this.userIdSelected = '',
  });

  @override
  List<Object?> get props => [users, userIdSelected];

  @override
  bool get isForeUpdateCollection => true;

  MainState copyWith({List<User>? users, String? userIdSelected}) => MainState(
        users: users ?? this.users,
        userIdSelected: userIdSelected ?? this.userIdSelected,
      );
}

class MainCubit extends CustomCubit<MainState> {
  MainCubit() : super(MainState());

  void init() {
    final users = User.genList();
    emit(MainState(users: users, userIdSelected: users.first.id));
  }

  onItemPressed(String id) {
    emit(state.copyWith(userIdSelected: id));
  }

  void updateDescription() {
    for (var element in state.users) {
      if (element.id == state.userIdSelected) {
        element.description += DateTime.now().millisecondsSinceEpoch.toString();
        emit(state.copyWith(users: state.users));
      }
    }
  }

  void onTodoPressed(String userId, String todoId) {
    for (var element in state.users) {
      if (element.id == userId) {
        for (var todo in element.todoList) {
          if (todo.id == todoId) {
            todo.isCompleted = !todo.isCompleted;
            emit(state.copyWith(users: state.users));
          }
        }
      }
    }
  }
}
