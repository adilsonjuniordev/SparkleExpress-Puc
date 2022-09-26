import 'package:sparkle_express/app/models/recibo.dart';
import 'package:sparkle_express/app/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

Future<int> saveLocal(Recibo recibo) async {
  try {
    Database db = await DatabaseConnection().setDatabase();

    db.insert("registros", {
      'id': null,
      'id_recibo': recibo.idRecibo,
      'email_motorista': recibo.emailMotorista,
      'empresa': recibo.empresa,
      'nome_func1': recibo.nomeFunc1,
      'matricula_func1': recibo.matrFunc1,
      'nome_func2': recibo.nomeFunc2,
      'matricula_func2': recibo.matrFunc2,
      'nome_func3': recibo.nomeFunc3,
      'matricula_func3': recibo.matrFunc3,
      'nome_func4': recibo.nomeFunc4,
      'matricula_func4': recibo.matrFunc4,
      'data': recibo.data,
      'hora_inicial': recibo.horaInicio,
      'hora_final': recibo.horaFim,
      'km_inicial': recibo.kmInicio,
      'km_final': recibo.kmFim,
      'km_percorrido': recibo.kmPercorrido,
      'origem': recibo.origem,
      'destino': recibo.destino,
      'pedagio': recibo.pedagio,
      'observacao': recibo.observacao,
      'url_imagem': recibo.arquivo,
    });

    return 1;
  } catch (e) {
    throw Exception(e);
  }
}
