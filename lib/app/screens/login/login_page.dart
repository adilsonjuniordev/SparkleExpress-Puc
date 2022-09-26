import 'package:sparkle_express/app/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';
import '../../widgets/my_field.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  final emailEC = TextEditingController();
  final senhaEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                              "assets/images/logo.png",
                              scale: 2.5,
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
                                    controller: emailEC,
                                    label: "Usuário",
                                    prefixIconButton: const Icon(Icons.person, color: Colors.white),
                                    inputType: TextInputType.emailAddress,
                                    validator: Validatorless.multiple([
                                      Validatorless.email("Email inválido"),
                                      Validatorless.required("Usuário obrigatório"),
                                    ]),
                                  ),
                                  const SizedBox(height: 20),
                                  MyField(
                                    controller: senhaEC,
                                    label: "Senha",
                                    prefixIconButton: const Icon(Icons.vpn_key_outlined, color: Colors.white),
                                    inputType: TextInputType.number,
                                    validator: Validatorless.required("Senha obrigatória"),
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
                                                    await controller.loginUser(emailEC.text, senhaEC.text);
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
