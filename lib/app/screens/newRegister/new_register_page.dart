import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sparkle_express/app/models/recibo.dart';
import 'package:sparkle_express/app/models/recibo_fields.dart';
import 'package:sparkle_express/app/repositories/recibos_sheets_api.dart';
import 'package:sparkle_express/app/repositories/save_local_register.dart';
import 'package:sparkle_express/app/ui/my_theme.dart';
import 'package:sparkle_express/app/widgets/my_date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sparkle_express/app/screens/newRegister/new_register_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:sparkle_express/app/widgets/my_button.dart';
import 'package:sparkle_express/app/widgets/my_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:validatorless/validatorless.dart';
import '../../repositories/upload_firebase.dart';
import '../../widgets/my_snackbar.dart';

// ignore: must_be_immutable
class NewRegister extends GetView<NewRegisterController> {
  NewRegister({Key? key}) : super(key: key);

  File? imgCompress;
  String imgName = "${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(99)}";

  final _formKey = GlobalKey<FormState>();
  final empresaEC = TextEditingController();
  final nomeFunc1EC = TextEditingController();
  final nomeFunc2EC = TextEditingController();
  final nomeFunc3EC = TextEditingController();
  final nomeFunc4EC = TextEditingController();
  final matriculaFunc1EC = TextEditingController();
  final matriculaFunc2EC = TextEditingController();
  final matriculaFunc3EC = TextEditingController();
  final matriculaFunc4EC = TextEditingController();
  final ucFunc1EC = TextEditingController();
  final ucFunc2EC = TextEditingController();
  final ucFunc3EC = TextEditingController();
  final ucFunc4EC = TextEditingController();
  final chefeFunc1EC = TextEditingController();
  final chefeFunc2EC = TextEditingController();
  final chefeFunc3EC = TextEditingController();
  final chefeFunc4EC = TextEditingController();
  final nomeMotoristaEC = TextEditingController();
  final dataEC = TextEditingController();
  final horaInicialEC = TextEditingController();
  final horaFinalEC = TextEditingController();
  final kmInicialEC = TextEditingController();
  final kmFinalEC = TextEditingController();
  final origemEC = TextEditingController();
  final destinoEC = TextEditingController();
  final pedagioEC = TextEditingController();
  final observacaoEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF404040),
            Color(0xFF000000),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        )),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/images/logo.png", height: 90),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("Novo recibo", style: TextStyle(color: Colors.white, fontSize: 24)),
                  const Text(
                    "Informe os dados para o recibo",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 51,
                    child: Row(
                      children: [
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              textTheme: const TextTheme(subtitle1: TextStyle(color: Colors.white)),
                              colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black),
                            ),
                            child: DropdownSearch<String>(
                              popupProps: PopupProps.dialog(
                                title: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text("Escolha uma empresa", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                  ),
                                ),
                                dialogProps: DialogProps(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                  elevation: 10,
                                  backgroundColor: Colors.grey,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                  barrierDismissible: true,
                                  barrierColor: Colors.black.withAlpha(180),
                                ),
                                scrollbarProps: const ScrollbarProps(
                                  thickness: 15,
                                  radius: Radius.circular(40),
                                ),
                                showSelectedItems: true,
                              ),
                              onChanged: (value) {
                                var c = controller;
                                c.empresaSelecionadaNome.value = value.toString();
                                c.empresaSelecionadaEmail.value = c.emails[c.empresas.indexOf(value.toString())];
                              },
                              items: controller.empresas,
                              dropdownSearchDecoration: const InputDecoration(
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                label: Text("Selecione a empresa", style: TextStyle(color: Colors.white)),
                                hintText: "Empresa",
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: MyTheme.primary.withAlpha(100), width: 1), borderRadius: const BorderRadius.all(Radius.circular(12))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Funcionário 1", style: TextStyle(color: MyTheme.primary.withAlpha(180), fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: MyField(
                                  label: "Matrícula",
                                  controller: matriculaFunc1EC,
                                  inputType: TextInputType.number,
                                  onChanged: (String value) => _pesquisaFuncionario(texto: value, nomeEC: nomeFunc1EC, matriculaEC: matriculaFunc1EC),
                                  validator: Validatorless.required("Obrigatório"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: nomeFunc1EC.text != ""
                                    ? MyField(
                                        label: "Nome",
                                        readOnly: true,
                                        fontsize: 12,
                                        controller: nomeFunc1EC,
                                        validator: Validatorless.required("Obrigatório"),
                                      )
                                    : MyField(
                                        label: "Nome",
                                        enabled: false,
                                        fontsize: 12,
                                        controller: nomeFunc1EC,
                                        validator: Validatorless.required("Obrigatório"),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: MyTheme.primary.withAlpha(100), width: 1), borderRadius: const BorderRadius.all(Radius.circular(12))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Funcionário 2\n(Opcional)", style: TextStyle(color: MyTheme.primary.withAlpha(180), fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: MyField(
                                  label: "Matrícula",
                                  controller: matriculaFunc2EC,
                                  inputType: TextInputType.number,
                                  onChanged: (String value) => _pesquisaFuncionario(texto: value, nomeEC: nomeFunc2EC, matriculaEC: matriculaFunc2EC),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: nomeFunc2EC.text != ""
                                    ? MyField(
                                        label: "Nome",
                                        readOnly: true,
                                        fontsize: 12,
                                        controller: nomeFunc2EC,
                                      )
                                    : MyField(
                                        label: "Nome",
                                        enabled: false,
                                        fontsize: 12,
                                        controller: nomeFunc2EC,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: MyTheme.primary.withAlpha(100), width: 1), borderRadius: const BorderRadius.all(Radius.circular(12))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Funcionário 3\n(Opcional)", style: TextStyle(color: MyTheme.primary.withAlpha(180), fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: MyField(
                                  label: "Matrícula",
                                  controller: matriculaFunc3EC,
                                  inputType: TextInputType.number,
                                  onChanged: (String value) => _pesquisaFuncionario(texto: value, nomeEC: nomeFunc3EC, matriculaEC: matriculaFunc3EC),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: nomeFunc3EC.text != ""
                                    ? MyField(
                                        label: "Nome",
                                        readOnly: true,
                                        fontsize: 12,
                                        controller: nomeFunc3EC,
                                      )
                                    : MyField(
                                        label: "Nome",
                                        enabled: false,
                                        fontsize: 12,
                                        controller: nomeFunc3EC,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: MyTheme.primary.withAlpha(100), width: 1), borderRadius: const BorderRadius.all(Radius.circular(12))),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text("Funcionário 4\n(Opcional)", style: TextStyle(color: MyTheme.primary.withAlpha(180), fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: MyField(
                                  label: "Matrícula",
                                  controller: matriculaFunc4EC,
                                  inputType: TextInputType.number,
                                  onChanged: (String value) => _pesquisaFuncionario(texto: value, nomeEC: nomeFunc4EC, matriculaEC: matriculaFunc4EC),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: nomeFunc4EC.text != ""
                                    ? MyField(
                                        label: "Nome",
                                        readOnly: true,
                                        fontsize: 12,
                                        controller: nomeFunc4EC,
                                      )
                                    : MyField(
                                        label: "Nome",
                                        enabled: false,
                                        fontsize: 12,
                                        controller: nomeFunc4EC,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: MyTheme.primary.withAlpha(50)),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: MyDateTimePicker(
                            type: DateTimePickerType.date,
                            onPressed: atualizaData,
                            calendarTitle: "SELECIONE A DATA DA CORRIDA",
                            cancelText: "CANCELAR",
                            dateLabelText: "Data",
                            dateMask: "dd/MM/yyyy",
                            labelText: "Data",
                            validator: Validatorless.required("Obrigatório"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyDateTimePicker(
                            type: DateTimePickerType.time,
                            onPressed: atualizaHoraInicio,
                            cancelText: "CANCELAR",
                            dateLabelText: "Hora",
                            labelText: "Hora Inicial",
                            validator: Validatorless.required("Obrigatório"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyDateTimePicker(
                            type: DateTimePickerType.time,
                            onPressed: atualizaHoraFim,
                            cancelText: "CANCELAR",
                            dateLabelText: "Hora",
                            labelText: "Hora Final",
                            validator: Validatorless.required("Obrigatório"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: MyTheme.primary.withAlpha(50)),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: MyField(
                            label: "KM Inicial",
                            controller: kmInicialEC,
                            onChanged: (value) {
                              controller.kmInicio.value = double.tryParse(value) ?? 0.0;
                            },
                            inputType: TextInputType.number,
                            validator: Validatorless.multiple([
                              Validatorless.required("KM obrigatório"),
                              Validatorless.number("Somente números"),
                              Validatorless.max(6, "Máximo de 6 dígitos"),
                            ]),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyField(
                            label: "KM Final",
                            controller: kmFinalEC,
                            onChanged: (value) {
                              controller.kmFinal.value = double.tryParse(value) ?? 0.0;
                            },
                            inputType: TextInputType.number,
                            validator: Validatorless.multiple([
                              Validatorless.required("KM obrigatório"),
                              Validatorless.number("Somente números"),
                              Validatorless.max(6, "Máximo de 6 dígitos"),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => controller.kmFinal.value > controller.kmInicio.value
                      ? Text("\nTotal percorrido: ${(controller.kmFinal.value - controller.kmInicio.value).toStringAsFixed(1)}km",
                          style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.bold))
                      : const SizedBox.shrink()),
                  Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: MyTheme.primary.withAlpha(50)),
                  SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: MyField(
                            label: "Endereço Origem",
                            controller: origemEC,
                            inputType: TextInputType.text,
                            validator: Validatorless.multiple([
                              Validatorless.required("Obrigatório"),
                            ]),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: MyField(
                            label: "Endereço Destino",
                            controller: destinoEC,
                            inputType: TextInputType.text,
                            validator: Validatorless.multiple([
                              Validatorless.required("Obrigatório"),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: MyTheme.primary.withAlpha(50)),
                  SizedBox(
                    child: MyField(
                      label: "Valor do Pedágio (R\$)",
                      controller: pedagioEC,
                      onChanged: (value) {
                        controller.pedagio.value = double.tryParse(value) ?? 0.0;
                      },
                      inputType: TextInputType.number,
                      validator: Validatorless.number("Use números e ponto"),
                    ),
                  ),
                  Divider(height: 30, thickness: 1, indent: 10, endIndent: 10, color: MyTheme.primary.withAlpha(50)),
                  SizedBox(
                    child: MyField(
                      label: "Observação",
                      controller: observacaoEC,
                      onChanged: (value) {},
                      inputType: TextInputType.text,
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyTheme.primary.withAlpha(100), width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Anexar comprovante de pedágio",
                          style: TextStyle(color: MyTheme.primary.withAlpha(180), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: callCameraAndCompress,
                                  icon: const Icon(Icons.photo_camera, color: Colors.black),
                                  label: const Text("Câmera", style: TextStyle(color: Colors.black)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: callGaleryAndCompress,
                                  icon: const Icon(Icons.photo, color: Colors.black),
                                  label: const Text("Galeria", style: TextStyle(color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() => controller.imagemAnexada.value == true
                            ? const Text("Imagem anexada com sucesso!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                            : const SizedBox.shrink()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => controller.enableButtonNew.value == true
                        ? MyButton(text: "Salvar", textColor: Colors.black, onPressed: _salvar)
                        : const MyButton(text: "Salvar", textColor: Colors.black, onPressed: null),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _salvar() async {
    var validForm = _formKey.currentState!.validate();

    User? user = FirebaseAuth.instance.currentUser;
    final String emailMotorista = user?.email ?? "";

    if (validForm) {
      if (controller.empresaSelecionadaNome.value != "") {
        if (double.parse(kmFinalEC.value.text) >= double.parse(kmInicialEC.value.text)) {
          controller.enableButtonNew.value = false;
          _somaPassageiros();

          Get.showOverlay(
            loadingWidget: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.yellow, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          strokeWidth: 8,
                          backgroundColor: Colors.grey.withAlpha(100),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Enviando", style: TextStyle(fontSize: 24, color: MyTheme.primary, decoration: TextDecoration.none)),
                    ],
                  ),
                ),
              ),
            ),
            asyncFunction: () async {
              try {
                if (await InternetConnectionChecker().hasConnection) {
                  try {
                    if (imgCompress != null) controller.urlImagem.value = await uploadFirebase(imgCompress!, imgName);
                  } catch (e) {
                    dev.log("Erro ao fazer upload da foto - ERRO: $e");
                    throw Exception("upload-error");
                  }

                  try {
                    var novoRecibo = Recibo(
                      idRecibo: imgName,
                      empresa: controller.empresaSelecionadaNome.value,
                      email: controller.empresaSelecionadaNome.value,
                      data: controller.dataSelecionada.value,
                      horaInicio: controller.horaInicial.value,
                      horaFim: controller.horaFinal.value,
                      nomeFunc1: nomeFunc1EC.text != "" ? nomeFunc1EC.text : "",
                      matrFunc1: nomeFunc1EC.text != "" ? matriculaFunc1EC.text : "",
                      nomeFunc2: nomeFunc2EC.text != "" ? nomeFunc2EC.text : "",
                      matrFunc2: nomeFunc2EC.text != "" ? matriculaFunc2EC.text : "",
                      nomeFunc3: nomeFunc3EC.text != "" ? nomeFunc3EC.text : "",
                      matrFunc3: nomeFunc3EC.text != "" ? matriculaFunc3EC.text : "",
                      nomeFunc4: nomeFunc4EC.text != "" ? nomeFunc4EC.text : "",
                      matrFunc4: nomeFunc4EC.text != "" ? matriculaFunc4EC.text : "",
                      emailMotorista: emailMotorista,
                      kmInicio: kmInicialEC.text,
                      kmFim: kmFinalEC.text,
                      kmPercorrido: (controller.kmFinal.value - controller.kmInicio.value).toStringAsFixed(1),
                      origem: origemEC.text,
                      destino: destinoEC.text,
                      passageiros: controller.passageiros.value.toString(),
                      pedagio: pedagioEC.text.replaceAll(".", ","),
                      observacao: observacaoEC.text,
                      arquivo: controller.urlImagem.value,
                    );

                    final recibo = {
                      ReciboFields.idRecibo: imgName,
                      ReciboFields.empresa: controller.empresaSelecionadaNome.value,
                      ReciboFields.email: controller.empresaSelecionadaEmail.value,
                      ReciboFields.data: controller.dataSelecionada.value,
                      ReciboFields.horaInicio: controller.horaInicial.value,
                      ReciboFields.horaFim: controller.horaFinal.value,
                      ReciboFields.nomeFunc1: nomeFunc1EC.text != "" ? nomeFunc1EC.text : "",
                      ReciboFields.matrFunc1: nomeFunc1EC.text != "" ? matriculaFunc1EC.text : "",
                      ReciboFields.nomeFunc2: nomeFunc2EC.text != "" ? nomeFunc2EC.text : "",
                      ReciboFields.matrFunc2: nomeFunc2EC.text != "" ? matriculaFunc2EC.text : "",
                      ReciboFields.nomeFunc3: nomeFunc3EC.text != "" ? nomeFunc3EC.text : "",
                      ReciboFields.matrFunc3: nomeFunc3EC.text != "" ? matriculaFunc3EC.text : "",
                      ReciboFields.nomeFunc4: nomeFunc4EC.text != "" ? nomeFunc4EC.text : "",
                      ReciboFields.matrFunc4: nomeFunc4EC.text != "" ? matriculaFunc4EC.text : "",
                      ReciboFields.matrMotorista: emailMotorista,
                      ReciboFields.kmInicio: kmInicialEC.text,
                      ReciboFields.kmFim: kmFinalEC.text,
                      ReciboFields.kmPercorrido: (controller.kmFinal.value - controller.kmInicio.value).toStringAsFixed(1),
                      ReciboFields.origem: origemEC.text,
                      ReciboFields.destino: destinoEC.text,
                      ReciboFields.passageiros: controller.passageiros.value.toString(),
                      ReciboFields.pedagio: pedagioEC.text.replaceAll(".", ","),
                      ReciboFields.observacao: observacaoEC.text,
                      ReciboFields.arquivo: controller.urlImagem.value,
                    };

                    await RecibosSheetsApi.insert([recibo]);
                    await Future.delayed(const Duration(seconds: 2));

                    controller.dadosEnviados.value = await RecibosSheetsApi.verify(novoRecibo.idRecibo);
                    if (controller.dadosEnviados.value) {
                      await saveLocal(novoRecibo);
                      Get.back();
                      MySnackbar().sendSuccess();
                    } else {
                      MySnackbar().sendFailed();
                    }
                  } catch (e) {
                    throw Exception("insert-data-error");
                  }
                } else {
                  throw Exception("internet-connection-error");
                }
              } on Exception catch (e) {
                if (e.toString() == "Exception: upload-error") MySnackbar().uploadFail();
                if (e.toString() == "Exception: insert-data-error") MySnackbar().sendFailed();
                if (e.toString() == "Exception: internet-connection-error") MySnackbar().noConnection();
              }
            },
          );
        } else {
          MySnackbar().kmMenor();
        }
        Future.delayed(const Duration(seconds: 3), () => controller.enableButtonNew.value = true);
      } else {
        MySnackbar().empresaNaoSelecionada();
      }
    } else {
      MySnackbar().camposObrigatorios();
    }

    controller.enableButtonNew.value = true;
  }

  callCameraAndCompress() async {
    var arquivo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (arquivo == null) return;
    controller.imagemAnexada.value = true;
    File imgTemporary = File(arquivo.path);
    var folderTemp = await getTemporaryDirectory();
    String folderFinal = join(folderTemp.path, "$imgName.jpg");
    imgCompress = await comprimirArquivo(imgTemporary, folderFinal);
  }

  callGaleryAndCompress() async {
    var arquivo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (arquivo == null) return;
    controller.imagemAnexada.value = true;
    File imgTemporary = File(arquivo.path);
    var folderTemp = await getTemporaryDirectory();
    String folderFinal = join(folderTemp.path, "$imgName.jpg");
    imgCompress = await comprimirArquivo(imgTemporary, folderFinal);
  }

  atualizaData(value) {
    controller.dataSelecionada.value = DateFormat("dd/MM/yyyy").format(DateFormat("yyyy-MM-dd").parse(value));
  }

  atualizaHoraInicio(value) {
    controller.horaInicial.value = (value);
  }

  atualizaHoraFim(value) {
    controller.horaFinal.value = (value);
  }

  Future<File> comprimirArquivo(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 30,
    );

    if (result != null) return result;
    throw Exception();
  }

  _pesquisaFuncionario({
    required String texto,
    required TextEditingController nomeEC,
    required TextEditingController matriculaEC,
  }) {
    if (texto.length >= 6) {
      int index = controller.matriculas.indexOf(texto);
      if (index >= 0) {
        nomeEC.text = controller.funcionarios[index]['nome'];
      } else {
        nomeEC.text = "";
      }
    } else {
      nomeEC.text = "";
    }
  }

  _somaPassageiros() {
    int quantPass = 1;
    if (nomeFunc2EC.text.isNotEmpty) quantPass++;
    if (nomeFunc3EC.text.isNotEmpty) quantPass++;
    if (nomeFunc4EC.text.isNotEmpty) quantPass++;

    controller.passageiros.value = quantPass;
  }
}
