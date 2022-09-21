import 'package:sparkle_express/app/ui/my_theme.dart';
import 'package:flutter/material.dart';
import '../ui/my_icons.dart';

class MyField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final Icon? prefixIconButton;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final double? fontsize;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final int? maxLines;
  final Function(String)? onChanged;

  MyField({
    Key? key,
    required this.label,
    this.suffixIconButton,
    this.prefixIconButton,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.fontsize,
    this.controller,
    this.validator,
    this.inputType,
    this.maxLines,
    this.onChanged,
  })  : assert(obscureText == true ? suffixIconButton == null : true, 'ObscureText não pode ser enviado em conjunto com suffixIconButton'),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return Theme(
          data: Theme.of(context).copyWith(primaryColor: MyTheme.primary),
          child: TextFormField(
            style: TextStyle(color: Colors.white, fontSize: fontsize),
            readOnly: readOnly,
            enabled: enabled,
            keyboardType: inputType,
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            cursorColor: MyTheme.primary,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              isDense: true,
              labelText: label,
              labelStyle: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
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
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: MyTheme.secondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: MyTheme.primary),
              ),
              suffixIcon: suffixIconButton ??
                  (obscureText == true
                      ? IconButton(
                          onPressed: () {
                            obscureTextVN.value = !obscureTextValue;
                          },
                          icon: Icon(!obscureTextValue ? MyIcons.eyeSlash : MyIcons.eye, size: 15, color: Colors.white),
                        )
                      : null),
              prefixIcon: prefixIconButton,
              prefixIconColor: MyTheme.primary,
              focusColor: MyTheme.primary,
            ),
            obscureText: obscureTextValue,
          ),
        );
      },
    );
  }
}
