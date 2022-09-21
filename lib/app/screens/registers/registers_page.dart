import 'package:sparkle_express/app/repositories/database_connection.dart';
import 'package:sparkle_express/app/screens/registers/registers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Registers extends GetView<RegistersController> {
  const Registers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
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
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/images/logo-taxi.png", height: 60),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Meus Registros", style: TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: SingleChildScrollView(
                  child: buildRegisters(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildRegisters() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: getRegisters(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(5),
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey.withAlpha(180), width: 1), borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.withAlpha(60),
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(child: Text("Data: ${snapshot.data![index]['data']}", style: const TextStyle(fontWeight: FontWeight.bold))),
                                Flexible(child: Text("Hora: ${snapshot.data![index]['hora_inicial']} até ${snapshot.data![index]['hora_final']}", style: const TextStyle(fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.key, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("ID: ${snapshot.data![index]['id_recibo']}")),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.business, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("Empresa: ${snapshot.data![index]['empresa']}")),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("Func 1: ${snapshot.data![index]['nome_func1']}", overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("Origem: ${snapshot.data![index]['origem']}")),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.local_taxi, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("KM Inicial: ${snapshot.data![index]['km_inicial']}")),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("Destino: ${snapshot.data![index]['destino']}")),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.local_taxi, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("KM Final: ${snapshot.data![index]['km_final']}")),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.sports_score_outlined, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("KM Percorrido: ${snapshot.data![index]['km_percorrido']}")),
                            ],
                          ),
                          snapshot.data![index]['pedagio'] != ""
                              ? Row(children: [
                                  const Icon(Icons.price_change_outlined, size: 18),
                                  const SizedBox(width: 4),
                                  Flexible(child: Text("Pedágio: R\$${snapshot.data![index]['pedagio']}")),
                                ])
                              : const SizedBox.shrink(),
                          Row(
                            children: [
                              const Icon(Icons.monetization_on_outlined, size: 18),
                              const SizedBox(width: 4),
                              Flexible(child: Text("Valor Total: R\$${snapshot.data![index]['valor_total']}")),
                            ],
                          ),
                          snapshot.data![index]['url_imagem'] == ""
                              ? const SizedBox.shrink()
                              : Row(
                                  children: [
                                    const Icon(Icons.attach_file, size: 18),
                                    InkWell(
                                      child: const Text(
                                        'Visualizar Anexo',
                                        style: TextStyle(color: Colors.blueAccent),
                                      ),
                                      onTap: () => launchUrlString(
                                        snapshot.data![index]['url_imagem'],
                                        mode: LaunchMode.externalApplication,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  children: const [
                    SizedBox(height: 50),
                    Icon(Icons.app_registration_outlined, color: Colors.white, size: 70),
                    Text("Nenhum registro ainda", style: TextStyle(color: Colors.white)),
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<Map<String, dynamic>>> getRegisters() async {
    final prefs = await SharedPreferences.getInstance();
    String? usuario = prefs.getString("usuario");

    if (usuario != null) {
      return await DatabaseConnection().getAllDataReversed(int.parse(usuario));
    }
    return [];
  }
}
