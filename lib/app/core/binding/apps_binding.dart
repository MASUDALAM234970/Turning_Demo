import 'package:get/get.dart';
import 'package:turningdemo/App/feature/auth/controller/RegisterController.dart';
import 'package:turningdemo/App/feature/auth/controller/login_Controller.dart';

class AppsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterControllers>(() => RegisterControllers(), fenix: true);

    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
  }
}
