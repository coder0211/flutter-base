import 'package:improve_base/model/todo.dart';
import 'package:uuid/uuid.dart';

class User {
  User({
    this.name = '',
    this.description = '',
    this.todoList,
  }) {
    id = const Uuid().v4();
  }
  late final String id;
  final String name;
  String description;
  TodoList? todoList;

  static List<User> genList() => [
        User(
          name: 'Hoa',
          description: 'Lorem ipsum dolor sit amet',
          todoList: TodoList(ls: Todo.genList()),
        ),
        User(
          name: 'Hoa 2',
          description: 'consectetur adipiscing elit.',
          todoList: TodoList(ls: Todo.genList()),
        ),
        User(
          name: 'Hoa Nguyen',
          description: 'Cras pharetra laoreet ex, vitae rutrum ligula pulvinar sit amet.',
          todoList: TodoList(ls: Todo.genList()),
        ),
      ];
}

class TodoList {
  TodoList({this.ls = const [], this.isLoading = false});

  List<Todo> ls;
  bool isLoading;
}
