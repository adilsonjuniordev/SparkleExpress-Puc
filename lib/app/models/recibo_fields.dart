class ReciboFields {
  static const String idRecibo = "ID";
  static const String empresa = "Empresa";
  static const String email = "Email";
  static const String data = "Data";
  static const String horaInicio = "Hora Inicial";
  static const String horaFim = "Hora Final";
  static const String nomeFunc1 = "Nome Func 1";
  static const String matrFunc1 = "Matricula Func 1";
  static const String nomeFunc2 = "Nome Func 2";
  static const String matrFunc2 = "Matricula Func 2";
  static const String nomeFunc3 = "Nome Func 3";
  static const String matrFunc3 = "Matricula Func 3";
  static const String nomeFunc4 = "Nome Func 4";
  static const String matrFunc4 = "Matricula Func 4";
  static const String matrMotorista = "Email Motorista";
  static const String kmInicio = "KM Inicial";
  static const String kmFim = "KM Final";
  static const String kmPercorrido = "KM Percorrido";
  static const String origem = "Endereço Origem";
  static const String destino = "Endereço Destino";
  static const String passageiros = "Passageiros";
  static const String pedagio = "Pedagio";
  static const String observacao = "Observacao";
  static const String arquivo = "Anexo";

  static List<String> getFields() => [
        idRecibo,
        empresa,
        email,
        data,
        horaInicio,
        horaFim,
        nomeFunc1,
        matrFunc1,
        nomeFunc2,
        matrFunc2,
        nomeFunc3,
        matrFunc3,
        nomeFunc4,
        matrFunc4,
        matrMotorista,
        kmInicio,
        kmFim,
        kmPercorrido,
        origem,
        destino,
        passageiros,
        pedagio,
        observacao,
        arquivo
      ];
}
