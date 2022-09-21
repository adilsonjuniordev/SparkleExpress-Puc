import 'package:sparkle_express/app/screens/newRegister/new_register_controller.dart';
import 'package:get/get.dart';

class NewRegisterBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NewRegisterController());
  }
}
