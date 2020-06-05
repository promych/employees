import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDatePicker extends StatelessWidget {
  final Function onSaved;

  const BirthDatePicker({Key key, @required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      onSaved: onSaved,
      validator: (value) => value == null ? 'Поле должно быть заполнено' : null,
      decoration: InputDecoration(
        hintText: 'Дата рождения',
        labelText: 'Дата рождения',
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        filled: true,
      ),
      format: DateFormat('dd.MM.yyyy'),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime.now());
      },
    );
  }
}
