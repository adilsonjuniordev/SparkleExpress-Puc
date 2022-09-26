class Recibo {
  String idRecibo;
  String empresa;
  String email;
  String data;
  String horaInicio;
  String horaFim;
  String nomeFunc1;
  String matrFunc1;
  String? nomeFunc2;
  String? matrFunc2;
  String? nomeFunc3;
  String? matrFunc3;
  String? nomeFunc4;
  String? matrFunc4;
  String? emailMotorista;
  String kmInicio;
  String kmFim;
  String kmPercorrido;
  String origem;
  String destino;
  String passageiros;
  String? pedagio;
  String? observacao;
  String? arquivo;

  Recibo({
    required this.idRecibo,
    required this.empresa,
    required this.email,
    required this.data,
    required this.horaInicio,
    required this.horaFim,
    required this.nomeFunc1,
    required this.matrFunc1,
    this.nomeFunc2,
    this.matrFunc2,
    this.nomeFunc3,
    this.matrFunc3,
    this.nomeFunc4,
    this.matrFunc4,
    this.emailMotorista,
    required this.kmInicio,
    required this.kmFim,
    required this.kmPercorrido,
    required this.origem,
    required this.destino,
    required this.passageiros,
    this.pedagio,
    this.observacao,
    this.arquivo,
  });
}
