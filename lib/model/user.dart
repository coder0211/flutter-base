import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({
    this.name = '',
    this.description = '',
  });
  final String name;
  String description;

  @override
  List<Object?> get props => [name, description];
}
