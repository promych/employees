import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/employee_manager.dart';
import '../../model/employee.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/date_picker.dart';

class EmployeeEditorPage extends StatefulWidget {
  final Employee employee;

  const EmployeeEditorPage({Key key, this.employee}) : super(key: key);

  @override
  _EmployeeEditorPageState createState() => _EmployeeEditorPageState();
}

class _EmployeeEditorPageState extends State<EmployeeEditorPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EmployeeManager _employeeManager;

  String _name;
  String _surname;
  String _patronymic;
  int _birthDate;
  String _position;

  @override
  void initState() {
    super.initState();
    _employeeManager = context.read<EmployeeManager>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.employee != null ? 'Редактирование' : 'Новый сотрудник'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                CustomTextFormField(
                  initValue:
                      (widget.employee != null) ? widget.employee.surname : '',
                  hintText: 'Фамилия',
                  onSaved: (value) => _surname = value,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  initValue:
                      (widget.employee != null) ? widget.employee.name : '',
                  hintText: 'Имя',
                  onSaved: (value) => _name = value,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  initValue: (widget.employee != null)
                      ? widget.employee.patronymic
                      : '',
                  hintText: 'Отчество',
                  onSaved: (value) => _patronymic = value,
                ),
                SizedBox(height: 20),
                BirthDatePicker(
                  onSaved: (DateTime value) =>
                      _birthDate = value.millisecondsSinceEpoch,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  initValue:
                      (widget.employee != null) ? widget.employee.position : '',
                  hintText: 'Должность',
                  onSaved: (value) => _position = value,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              final employee = widget.employee;
              (employee == null)
                  ? await _employeeManager.addEmployee(Employee(
                      name: _name,
                      surname: _surname,
                      patronymic: _patronymic,
                      birthDate: _birthDate,
                      position: _position,
                      created: DateTime.now().millisecondsSinceEpoch,
                    ))
                  : await _employeeManager.updateEmployee(employee.copyWith(
                      name: _name,
                      surname: _surname,
                      patronymic: _patronymic,
                      birthDate: _birthDate,
                      position: _position,
                    ));

              Navigator.of(context).pop();
            }
          }),
    );
  }
}
