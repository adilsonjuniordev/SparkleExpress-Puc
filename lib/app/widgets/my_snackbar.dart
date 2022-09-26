import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/my_theme.dart';

class MySnackbar {
  void noConnection() {
    Get.snackbar(
      "Erro de conexão",
      "Falha na conexão, ou internet muito lenta.",
      titleText: const Text("Erro de conexão", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Falha na conexão, ou internet muito lenta.", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: MyTheme.error.withAlpha(240),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void sendSuccess() async {
    Get.snackbar(
      "Sucesso",
      "Os dados foram enviados!",
      titleText: const Text("Sucesso", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Os dados foram enviados!", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: Colors.green.withAlpha(200),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void sendFailed() {
    Get.snackbar(
      "Ops!",
      "Falha ao enviar dados.",
      titleText: const Text("Ops!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Falha ao enviar dados.", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: MyTheme.error.withAlpha(240),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void empresaNaoSelecionada() {
    Get.snackbar(
      "Ops!",
      "Selecione a empresa para continuar.",
      titleText: const Text("Ops!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Selecione a empresa para continuar.", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: MyTheme.error.withAlpha(240),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void camposObrigatorios() {
    Get.snackbar(
      "Ops!",
      "Preencha os campos obrigatórios.",
      titleText: const Text("Ops!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Preencha os campos obrigatórios.", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: MyTheme.error.withAlpha(240),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void kmMenor() {
    Get.snackbar(
      "Ops!",
      "KM inicial é menor que KM final",
      titleText: const Text("Ops!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("KM inicial é menor que KM final", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: MyTheme.error.withAlpha(240),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void loading() {
    Get.snackbar(
      "Aguarde",
      "Sincronizando dados...",
      titleText: const Text("Aguarde", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Sincronizando dados...", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: Colors.black.withAlpha(200),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.black.withAlpha(200),
      barBlur: 3,
      isDismissible: false,
      borderRadius: 6,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.timer, color: Colors.white, size: 40),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void loginSuccess() async {
    Get.snackbar(
      "Sucesso",
      "Seja bem-vindo",
      titleText: const Text("Sucesso", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Seja bem-vindo", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: Colors.green.withAlpha(200),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void loginFailed() {
    Get.snackbar(
      "Ops!",
      "Usuário ou senha inválidos",
      titleText: const Text("Ops!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Usuário ou senha inválidos", style: TextStyle(color: Colors.black, fontSize: 16)),
      backgroundColor: MyTheme.primary,
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.black, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void uploadFail() {
    Get.snackbar(
      "Erro de upload",
      "Falha no envio da foto.",
      titleText: const Text("Erro de upload", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: const Text("Falha no envio da foto.", style: TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: MyTheme.error.withAlpha(235),
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void failed(String message) {
    Get.snackbar(
      "Ops!",
      message,
      titleText: const Text("Ops!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: Text(message, style: const TextStyle(color: Colors.black, fontSize: 16)),
      backgroundColor: MyTheme.error,
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.black, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }

  void success(String message) {
    Get.snackbar(
      "Sucesso!",
      message,
      titleText: const Text("Sucesso!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      messageText: Text(message, style: const TextStyle(color: Colors.white, fontSize: 16)),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      barBlur: 1,
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.black, size: 40),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
    );
  }
}
