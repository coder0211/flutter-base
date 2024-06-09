import 'package:improve_base/equatable/equality.dart';

import 'equatable.dart';

bool equals(
  List<Object?>? currentProps,
  List<Object?>? nextProps, {
  bool isForeUpdateCollection = false,
}) {
  if (identical(currentProps, nextProps)) return true;
  if (currentProps == null || nextProps == null) return false;
  final length = currentProps.length;
  if (length != nextProps.length) return false;

  for (var i = 0; i < length; i++) {
    if (!_compare(
      currentProps[i],
      nextProps[i],
      isForeUpdateCollection: isForeUpdateCollection,
    )) return false;
  }
  return true;
}

bool _compare(
  Object? unit1,
  Object? unit2, {
  bool isForeUpdateCollection = false,
}) {
  const DeepCollectionEquality collectionEquality = DeepCollectionEquality();

  if (isEquatable(unit1) && isEquatable(unit2)) {
    if (unit1 != unit2) return false;
  } else if (unit1 is Iterable || unit1 is Map) {
    if (isForeUpdateCollection) return false;
    if (!collectionEquality.equals(unit1, unit2)) return false;
  } else if (unit1?.runtimeType != unit2?.runtimeType) {
    return false;
  } else if (unit1 != unit2) {
    return false;
  }
  return true;
}

bool isEquatable(Object? object) => object is Equatable;
