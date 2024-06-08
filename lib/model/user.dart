import 'package:improve_base/model/todo.dart';
import 'package:uuid/uuid.dart';

class User {
  User({
    this.name = '',
    this.description = '',
    this.todoList = const [],
  }) {
    id = const Uuid().v4();
  }
  late final String id;
  final String name;
  String description;
  List<Todo> todoList;

  static List<User> genList() => [
        User(
          name: 'Hoa',
          description: 'Lorem ipsum dolor sit amet',
          todoList: Todo.genList(),
        ),
        User(
          name: 'Hoa 2',
          description: 'consectetur adipiscing elit.',
          todoList: Todo.genList(),
        ),
        User(
          name: 'Hoa Nguyen',
          description: 'Cras pharetra laoreet ex, vitae rutrum ligula pulvinar sit amet.',
          todoList: Todo.genList(),
        ),
      ];
}
