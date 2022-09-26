import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../widgets/my_snackbar.dart';

class LoginController extends GetxController {
  RxBool enableButtonLogin = true.obs;

  Future loginUser(String email, String senha) async {
    enableButtonLogin.value = false;
    MySnackbar().loading();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha).then(
        (credential) {
          if (credential.user != null) {
            enableButtonLogin.value = true;
            Get.offAndToNamed('/home');
            MySnackbar().loginSuccess();
          }
          enableButtonLogin.value = true;
          Get.closeAllSnackbars();
        },
      );
    } on FirebaseAuthException catch (e) {
      var message = "";
      if (e.code == "invalid-email") message = "Email inválido.";
      if (e.code == "user-disabled") message = "Usuário desabilitado.";
      if (e.code == "user-not-found") message = "Email não cadastrado.";
      if (e.code == "wrong-password") message = "Senha incorreta.";
      enableButtonLogin.value = true;
      MySnackbar().failed(message);
    }
  }
}
