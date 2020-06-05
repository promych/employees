import 'package:flutter/foundation.dart';

import 'unit_interface.dart';

class Employee extends Unit {
  final String position;
  String id;

  Employee({
    @required name,
    @required surname,
    patronymic,
    @required birthDate,
    @required this.position,
    @required created,
  }) : super(
          name: name as String,
          surname: surname as String,
          patronymic: patronymic as String,
          birthDate: birthDate as int,
          created: created as int,
        );

  factory Employee.fromMap(Map<String, dynamic> data) => Employee(
        name: data['name'],
        surname: data['surname'],
        patronymic: data['patronymic'] ?? '',
        birthDate: data['birthDate'],
        position: data['position'],
        created: data['created'],
      );

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'surname': this.surname,
        'patronymic': this.patronymic,
        'birthDate': this.birthDate,
        'position': this.position,
        'created': this.created,
      };

  Employee copyWith({
    String name,
    String surname,
    String patronymic,
    int birthDate,
    String position,
  }) {
    return Employee(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      patronymic: patronymic ?? this.patronymic,
      birthDate: birthDate ?? this.birthDate,
      position: position ?? this.position,
      created: this.created,
    )..id = this.id;
  }
}
