import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../env/env.dart';
import '../../repositories/database_connection.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 1));
    await inicializador();
    super.onReady();
  }

  inicializador() async {
    await buscaEmpresas();
    await buscaFuncionarios();
    await isLoggedIn();
  }

  Future isLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user != null) {
      Get.offAndToNamed('/home');
    } else {
      Get.offAndToNamed('/login');
    }
  }

  buscaEmpresas() async {
    try {
      List listaEmpresas = [];
      var socket = GetConnect();
      var response = await socket.get(Env.i['sheet_id_empresas']!);
      listaEmpresas = await (jsonDecode(response.bodyString.toString())).map((e) => {'empresa': e['empresas'], 'email': e['emails']}).toList();

      Database db = await DatabaseConnection().setDatabase();

      if (listaEmpresas.isNotEmpty) {
        await db.rawQuery("DELETE FROM empresas");

        for (var empresa in listaEmpresas) {
          try {
            await db.rawInsert('INSERT INTO empresas(empresa, email) VALUES(?, ?)', [empresa['empresa'], empresa['email']]);
          } catch (e) {
            log("Erro ao gravar empresa no banco");
          }
        }
      }

      await db.close();
    } catch (e) {
      log("Sem conexao com a internet");
    }
  }

  buscaFuncionarios() async {
    try {
      List listaFuncionarios = [];
      var socket = GetConnect();
      var response = await socket.get(Env.i["sheet_id_funcionarios"]!);

      listaFuncionarios = await (jsonDecode(response.bodyString.toString())).map((e) => {'matricula': e['matricula'], 'nome': e['nome']}).toList();

      Database db = await DatabaseConnection().setDatabase();

      if (listaFuncionarios.isNotEmpty) {
        await db.rawQuery("DELETE FROM funcionarios");

        for (var funcionario in listaFuncionarios) {
          try {
            await db.rawInsert('INSERT INTO funcionarios(matricula, nome) VALUES(?, ?)', [funcionario['matricula'], funcionario['nome']]);
          } catch (e) {
            log("Erro ao gravar funcionario no banco");
          }
        }
      }
    } catch (e) {
      log("Sem conexao com a internet");
    }
  }
}
