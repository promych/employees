import 'package:flutter/foundation.dart';

class Unit {
  final String name;
  final String surname;
  final String patronymic;
  final int birthDate;
  final int created;

  Unit({
    @required this.name,
    @required this.surname,
    this.patronymic,
    @required this.birthDate,
    @required this.created,
  });
}
