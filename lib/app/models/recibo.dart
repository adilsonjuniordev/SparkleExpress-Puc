class Recibo {
  String idRecibo;
  String empresa;
  String email;
  String data;
  String horaInicio;
  String horaFim;
  String nomeFunc1;
  String matrFunc1;
  String ucFunc1;
  String chefeFunc1;
  String? nomeFunc2;
  String? matrFunc2;
  String? ucFunc2;
  String? chefeFunc2;
  String? nomeFunc3;
  String? matrFunc3;
  String? ucFunc3;
  String? chefeFunc3;
  String? nomeFunc4;
  String? matrFunc4;
  String? ucFunc4;
  String? chefeFunc4;
  String matriculaMotorista;
  String nomeMotorista;
  String kmInicio;
  String kmFim;
  String kmPercorrido;
  String origem;
  String destino;
  String passageiros;
  String? pedagio;
  String? valorTotal;
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
    required this.ucFunc1,
    required this.chefeFunc1,
    this.nomeFunc2,
    this.matrFunc2,
    this.ucFunc2,
    this.chefeFunc2,
    this.nomeFunc3,
    this.matrFunc3,
    this.ucFunc3,
    this.chefeFunc3,
    this.nomeFunc4,
    this.matrFunc4,
    this.ucFunc4,
    this.chefeFunc4,
    required this.matriculaMotorista,
    required this.nomeMotorista,
    required this.kmInicio,
    required this.kmFim,
    required this.kmPercorrido,
    required this.origem,
    required this.destino,
    required this.passageiros,
    this.pedagio,
    this.valorTotal,
    this.arquivo,
  });
}
