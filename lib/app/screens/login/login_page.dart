import 'package:sparkle_express/app/screens/login/login_controller.dart';
import 'package:sparkle_express/app/screens/login/repository/user_repository_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validatorless/validatorless.dart';
import '../../widgets/my_field.dart';
import '../../widgets/my_snackbar.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  final usuarioEC = TextEditingController();
  final senhaEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF404040),
            Color(0xFF000000),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        )),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 60),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Image.asset(
                              "assets/images/logo-taxi.png",
                              scale: 4,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  MyField(
                                    controller: usuarioEC,
                                    label: "Usuário",
                                    prefixIconButton: const Icon(Icons.person, color: Colors.white),
                                    inputType: TextInputType.number,
                                    validator: Validatorless.multiple([
                                      Validatorless.number("Somente números são aceitos"),
                                      Validatorless.min(5, "Usuário deve ter pelo menos 5 números"),
                                      Validatorless.required("Usuário obrigatório"),
                                    ]),
                                  ),
                                  const SizedBox(height: 20),
                                  MyField(
                                    controller: senhaEC,
                                    label: "Senha",
                                    prefixIconButton: const Icon(Icons.vpn_key_outlined, color: Colors.white),
                                    inputType: TextInputType.number,
                                    validator: Validatorless.multiple([
                                      Validatorless.required("Senha obrigatória"),
                                      Validatorless.min(3, "Senha deve ter pelo menos 3 caracteres"),
                                    ]),
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(
                                        () => ElevatedButton(
                                          onPressed: controller.enableButtonLogin.value == true
                                              ? () async {
                                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                                  if (!currentFocus.hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }

                                                  final validForm = _formKey.currentState?.validate() ?? false;
                                                  if (validForm) {
                                                    controller.enableButtonLogin.value = false;
                                                    MySnackbar().loading();
                                                    var result = await UserRepositoryLogin().buscaDadosLogin();
                                                    if (result != null) {
                                                      var login = await UserRepositoryLogin().validaLogin(
                                                        usuario: usuarioEC.text,
                                                        senha: senhaEC.text,
                                                        dados: result,
                                                      );

                                                      if (login) {
                                                        Get.closeAllSnackbars();
                                                        MySnackbar().loginSuccess();
                                                        Get.offAndToNamed('/home');
                                                        Future.delayed(const Duration(seconds: 3), () => controller.enableButtonLogin.value = true);
                                                      } else {
                                                        Get.closeAllSnackbars();
                                                        MySnackbar().loginFailed();
                                                        Future.delayed(const Duration(seconds: 3), () => controller.enableButtonLogin.value = true);
                                                      }
                                                    } else {
                                                      controller.enableButtonLogin.value = true;
                                                      MySnackbar().noConnection();
                                                    }
                                                  }
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            elevation: 10,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Entrar ",
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                                                ),
                                                Icon(
                                                  Icons.login_rounded,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xffF5CF16).withAlpha(5),
                            border: Border(
                              top: BorderSide(
                                width: 2,
                                color: Colors.grey.withAlpha(120),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Desenvolvido por:",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Get.defaultDialog(
                                    title: "Desenvolvedor",
                                    barrierDismissible: false,
                                    content: Column(
                                      children: [
                                        ClipRRect(borderRadius: BorderRadius.circular(80), child: Image.asset("assets/images/adilson.jpg", width: 80)),
                                        const SizedBox(height: 5),
                                        const Text("Adilson Junior", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 15),
                                        const Text("Desenvolvedor Mobile e Web", style: TextStyle(fontSize: 16)),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25, right: MediaQuery.of(context).size.width * 0.25),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const FaIcon(FontAwesomeIcons.linkedin, size: 22),
                                                  const SizedBox(width: 5),
                                                  InkWell(
                                                    child: const Text(
                                                      "Linkedin",
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        decoration: TextDecoration.underline,
                                                      ),
                                                    ),
                                                    onTap: () async => await launchUrl(Uri.https("www.linkedin.com", "/in/adilsonjuniordev")),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const FaIcon(FontAwesomeIcons.envelope, size: 20),
                                                  const SizedBox(width: 5),
                                                  InkWell(
                                                    child: const Text(
                                                      "Web Site",
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        decoration: TextDecoration.underline,
                                                      ),
                                                    ),
                                                    onTap: () async => await launchUrl(Uri.https("adilsonjuniordev.github.io", ""), mode: LaunchMode.externalApplication),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    radius: 10,
                                    cancel: ElevatedButton(
                                      onPressed: () => Get.back(),
                                      child: const Text(
                                        "Fechar",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    cancelTextColor: const Color(0xffF5CF16),
                                  );
                                },
                                child: const Text(
                                  "Adilson Junior",
                                  style: TextStyle(decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
