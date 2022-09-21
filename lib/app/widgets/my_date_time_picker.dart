import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import '../ui/my_theme.dart';

class MyDateTimePicker extends StatelessWidget {
  final DateTimePickerType type;
  final FormFieldValidator<String>? validator;
  final String? dateLabelText;
  final String? calendarTitle;
  final String? cancelText;
  final String? dateMask;
  final String? labelText;
  final Function(String) onPressed;

  const MyDateTimePicker({
    Key? key,
    required this.type,
    this.validator,
    this.dateLabelText,
    this.calendarTitle,
    this.cancelText,
    this.dateMask,
    this.labelText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      type: type,
      validator: validator,
      firstDate: DateTime(2021),
      lastDate: DateTime(2040),
      dateLabelText: dateLabelText,
      calendarTitle: calendarTitle,
      cancelText: cancelText,
      dateMask: dateMask,
      onChanged: onPressed,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: MyTheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: MyTheme.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: MyTheme.primary),
        ),
        isDense: true,
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      locale: const Locale('pt', 'BR'),
    );
  }
}
