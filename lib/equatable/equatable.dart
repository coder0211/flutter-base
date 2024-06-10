// Copyright (c) Equatable 2.0.5
import 'equatable_utils.dart';

abstract class Equatable {
  const Equatable();

  List<Object?> get props;

  bool get isForeUpdateCollection => false;

  @override
  bool operator ==(Object other) {
    return _compare(other);
  }

  bool _compare(Object other) {
    if (!isEquatable(other)) return false;
    if (identical(this, other)) return true;
    if (runtimeType == other.runtimeType &&
        equals(props, (other as Equatable).props, isForeUpdateCollection: isForeUpdateCollection)) return true;
    return false;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
