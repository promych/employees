import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/children_manager.dart';
import '../../model/employee_child.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/date_picker.dart';

class ChildEditorPage extends StatefulWidget {
  final String parentId;
  final String initSurname;

  const ChildEditorPage({
    Key key,
    @required this.parentId,
    this.initSurname,
  }) : super(key: key);

  @override
  _ChildEditorPageState createState() => _ChildEditorPageState();
}

class _ChildEditorPageState extends State<ChildEditorPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ChildrenManager _childrenManager;

  String _name;
  String _surname;
  String _patronymic;
  int _birthDate;

  @override
  void initState() {
    super.initState();
    _childrenManager = context.read<ChildrenManager>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ребенок')),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                CustomTextFormField(
                  initValue: widget.initSurname,
                  hintText: 'Фамилия',
                  onSaved: (value) => _surname = value,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Имя',
                  onSaved: (value) => _name = value,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Отчество',
                  onSaved: (value) => _patronymic = value,
                ),
                SizedBox(height: 20),
                BirthDatePicker(
                  onSaved: (DateTime value) =>
                      _birthDate = value.millisecondsSinceEpoch,
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

              await _childrenManager.addChild(EmployeeChild(
                name: _name,
                surname: _surname,
                patronymic: _patronymic,
                birthDate: _birthDate,
                created: DateTime.now().millisecondsSinceEpoch,
                parentId: widget.parentId,
              ));

              Navigator.of(context).pop();
            }
          }),
    );
  }
}
