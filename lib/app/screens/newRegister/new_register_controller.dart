import 'package:sparkle_express/app/repositories/database_connection.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class NewRegisterController extends GetxController {
  RxBool enableButtonNew = true.obs;
  RxBool imagemAnexada = false.obs;
  RxBool dadosEnviados = false.obs;
  RxString dataSelecionada = "".obs;
  RxString empresaSelecionadaNome = "".obs;
  RxString empresaSelecionadaEmail = "".obs;
  RxString horaInicial = "".obs;
  RxString horaFinal = "".obs;
  RxString urlImagem = "".obs;
  RxDouble kmInicio = 0.0.obs;
  RxDouble kmFinal = 0.0.obs;
  RxDouble pedagio = 0.0.obs;
  RxInt passageiros = 1.obs;
  List registros = [];
  List funcionarios = [];
  List matriculas = [];
  RxString resposta = "".obs;
  RxList<String> empresas = <String>[].obs;
  RxList<String> emails = <String>[].obs;

  Future<void> carregaEmpresas() async {
    Database db = await DatabaseConnection().setDatabase();
    var empresasTemp = await db.rawQuery("SELECT * FROM empresas");
    for (var element in empresasTemp) {
      empresas.add(element['empresa'].toString());
      emails.add(element['email'].toString());
    }
  }

  Future<void> carregaFuncionarios() async {
    Database db = await DatabaseConnection().setDatabase();
    var funcionariosTemp = await db.rawQuery("SELECT * FROM funcionarios");
    for (var func in funcionariosTemp) {
      matriculas.add(func['matricula']);
      funcionarios.add({'uc': func['uc'], 'matricula': func['matricula'], 'nome': func['nome'], 'chefe': func['chefe']});
    }
  }

  @override
  void onInit() async {
    await carregaEmpresas();
    await carregaFuncionarios();
    super.onInit();
  }
}
