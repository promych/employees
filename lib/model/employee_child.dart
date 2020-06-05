import 'package:flutter/foundation.dart';

import 'unit_interface.dart';

class EmployeeChild extends Unit {
  final String parentId;

  EmployeeChild({
    @required name,
    @required surname,
    patronymic,
    @required birthDate,
    @required created,
    @required this.parentId,
  }) : super(
          name: name as String,
          surname: surname as String,
          patronymic: patronymic as String,
          birthDate: birthDate as int,
          created: created as int,
        );

  factory EmployeeChild.fromMap(Map<String, dynamic> data) => EmployeeChild(
        name: data['name'],
        surname: data['surname'],
        patronymic: data['patronymic'] ?? '',
        birthDate: data['birthDate'],
        created: data['created'],
        parentId: data['parentId']
      );

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'surname': this.surname,
        'patronymic': this.patronymic,
        'birthDate': this.birthDate,
        'created': this.created,
        'parentId': this.parentId
      };

  EmployeeChild copyWith({
    String name,
    String surname,
    String patronymic,
    int birthDate,
    String position,
  }) {
    return EmployeeChild(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      patronymic: patronymic ?? this.patronymic,
      birthDate: birthDate ?? this.birthDate,
      parentId: this.parentId,
      created: this.created,
    );
  }
}
