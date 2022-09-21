import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    getPermission();
    super.onReady();
  }

  getPermission() async {
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }
}
