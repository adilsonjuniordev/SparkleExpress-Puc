import 'package:sparkle_express/app/screens/home/home_controller.dart';
import 'package:sparkle_express/app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../repositories/logout.dart';

final HomeController controller = Get.put(HomeController());

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 70, 10, 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF404040),
            Color(0xFF000000),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/logo-taxi.png", scale: 6),
                ),
              ),
              const SizedBox(height: 30),
              MyButton(text: "Gerar recibo", icon: Icons.create, bgColor: const Color(0xffF5CF16), textColor: Colors.black, onPressed: () => Get.toNamed('/newRegister')),
              const SizedBox(height: 12),
              MyButton(text: "Meus recibos", icon: Icons.menu_book, iconColor: Colors.white, bgColor: Colors.blueGrey, onPressed: () => Get.toNamed('/registers')),
              const SizedBox(height: 12),
              MyButton(
                text: "Sair",
                icon: Icons.logout,
                iconColor: Colors.white,
                bgColor: Colors.redAccent.withAlpha(200),
                onPressed: () {
                  logoutConfirm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
