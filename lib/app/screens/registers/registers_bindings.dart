import 'package:sparkle_express/app/screens/registers/registers_controller.dart';
import 'package:get/get.dart';

class RegistersBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(RegistersController());
  }
}
