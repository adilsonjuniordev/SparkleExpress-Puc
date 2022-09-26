import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './splash_controller.dart';

class SplashPage extends GetView<SplashController> {

    const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/logo.png'),
      backgroundColor: Colors.black87,
      showLoader: true,
      logoSize: 120,
      loadingText: const Text("Carregando", style: TextStyle(color: Colors.yellow, fontSize: 20)),
      loaderColor: Colors.yellow,
    );
  }
}