import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryLogin extends GetConnect {
  Future<dynamic> buscaDadosLogin() async {
    var response = await get('https://opensheet.elk.sh/150wE8XP1Vz0u0DYsAumMymyE9XMnAf2_8JHI6fxmffQ/login');
    return response.body;
  }

  Future<bool> validaLogin({required String usuario, required String senha, required dynamic dados}) async {
    for (var dado in dados) {
      if (usuario == dado['usuario']) {
        if (senha == dado['senha']) {
          try {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('logged', true);
            await prefs.setString('usuario', dado['usuario']);
            await prefs.setString('nome', dado['nome']);
            return true;
          } catch (e) {
            return false;
          }
        }
      }
    }
    return false;
  }
}
