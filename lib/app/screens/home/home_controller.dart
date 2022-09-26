import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../ui/my_theme.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    getPermission();
    super.onReady();
  }

  getPermission() async {
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

  logoutConfirm() async {
    Get.defaultDialog(
      title: "Atenção",
      titleStyle: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.bold),
      middleText: "Você quer sair da sua conta?\n\nSerá necessário fazer login novamente",
      middleTextStyle: TextStyle(color: MyTheme.primary),
      backgroundColor: Colors.blueGrey,
      textConfirm: "Sair",
      onConfirm: logout,
      textCancel: "Cancelar",
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.black,
      buttonColor: MyTheme.primary,
      barrierDismissible: true,
      radius: 8,
    );
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    await Get.offAllNamed("/login");
  }
}
