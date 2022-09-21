import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? bgColor;
  final Color? textColor;
  final Color? iconColor;
  final bool? enableButton;
  final String text;
  final Function? onPressed;
  final IconData? icon;

  const MyButton({
    Key? key,
    this.bgColor,
    this.textColor,
    this.iconColor,
    this.icon,
    required this.text,
    required this.onPressed,
    this.enableButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        backgroundColor: bgColor,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null ? Icon(icon, color: iconColor ?? Colors.black) : const SizedBox(),
          icon != null ? const SizedBox(width: 6) : const SizedBox(),
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
