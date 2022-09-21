import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadFirebase(File arquivo, String nome) async {
  final storageRef = FirebaseStorage.instance.ref();
  final mountainImagesRef = storageRef.child("pedagio/$nome");
  try {
    await mountainImagesRef.putFile(arquivo).timeout(const Duration(seconds: 7));
    String url = await mountainImagesRef.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    throw Exception(e);
  }
}
