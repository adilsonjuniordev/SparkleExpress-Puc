import 'dart:convert';
import 'dart:developer';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:sparkle_express/app/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../repositories/database_connection.dart';
import 'login/login_page.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/logo-taxi.png'),
      backgroundColor: Colors.black87,
      showLoader: true,
      logoSize: 120,
      loadingText: const Text("Carregando", style: TextStyle(color: Colors.yellow, fontSize: 20)),
      loaderColor: Colors.yellow,
      futureNavigator: inicializador(),
    );
  }

  Future<Widget> inicializador() async {
    await buscaEmpresas();
    await buscaFuncionarios();
    var home = await isLoggedIn();
    return home;
  }

  Future<Widget> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool logged = prefs.getBool('logged') ?? false;

    if (logged) {
      return await Future.delayed(const Duration(seconds: 2), (() => const HomePage()));
    }
    return await Future.delayed(const Duration(seconds: 2), (() => LoginPage()));
  }

  buscaEmpresas() async {
    try {
      List listaEmpresas = [];
      var socket = GetConnect();
      var response = await socket.get('https://opensheet.elk.sh/1cK6Cf1jYTA7U0CNtexl28-jbq2B311U3WFXj4QfSv9M/empresas');
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
      var response = await socket.get('https://opensheet.elk.sh/1yEqioM6DhIAQIgd0oNIG3lNT6IZnyKtjA3qLa8--anE/funcionarios');

      listaFuncionarios = await (jsonDecode(response.bodyString.toString())).map((e) => {'uc': e['uc'], 'matricula': e['matricula'], 'nome': e['nome'], 'chefe': e['chefe']}).toList();

      Database db = await DatabaseConnection().setDatabase();

      if (listaFuncionarios.isNotEmpty) {
        await db.rawQuery("DELETE FROM funcionarios");

        for (var funcionario in listaFuncionarios) {
          try {
            await db.rawInsert('INSERT INTO funcionarios(uc, matricula, nome, chefe) VALUES(?, ?, ?, ?)', [funcionario['uc'], funcionario['matricula'], funcionario['nome'], funcionario['chefe']]);
          } catch (e) {
            log("Erro ao gravar empresa no banco");
          }
        }
      }
    } catch (e) {
      log("Sem conexao com a internet");
    }
  }
}
