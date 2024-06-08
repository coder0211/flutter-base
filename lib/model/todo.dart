import 'package:uuid/uuid.dart';

class Todo {
  Todo({
    this.content = '',
    this.isCompleted = false,
  }) {
    id = const Uuid().v4();
  }

  late final String id;
  String content;
  bool isCompleted;

  static List<Todo> genList() => [
        Todo(
          content:
              'Duis finibus, eros eget accumsan varius, ligula tellus luctus odio, ac tincidunt erat arcu id massa.',
        ),
        Todo(
          content: 'Ut leo lorem, efficitur sit amet ultricies ac, pharetra ut eros.',
        ),
        Todo(
          content: 'Ut in ultrices orci.',
        ),
        Todo(
          content: 'Aliquam mi justo, laoreet a massa id, placerat molestie leo.',
        ),
      ];
}
