import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String initValue;
  final String hintText;
  final Function onSaved;

  const CustomTextFormField({
    Key key,
    this.initValue,
    @required this.onSaved,
    @required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValue,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        filled: true,
      ),
      onSaved: onSaved,
      validator: (value) =>
          value.trim().isEmpty ? 'Поле должно быть заполнено' : null,
    );
  }
}
