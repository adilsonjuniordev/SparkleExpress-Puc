import 'package:sparkle_express/app/ui/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

logoutConfirm() async {
  Get.defaultDialog(
    title: "Atenção",
    titleStyle: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.bold),
    middleText: "Você quer sair da sua conta?\n\nSerá necessário fazer login novamente",
    middleTextStyle: TextStyle(color: MyTheme.primary),
    backgroundColor: Colors.black,
    textConfirm: "Sair",
    onConfirm: logout,
    textCancel: "Cancelar",
    cancelTextColor: MyTheme.primary,
    confirmTextColor: Colors.black,
    buttonColor: MyTheme.primary,
    barrierDismissible: true,
    radius: 8,
  );
}

logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('logged', false);
  prefs.setString('usuario', "");
  prefs.setString('nome', "");
  await Get.offAllNamed("/login");
}
