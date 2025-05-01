import 'package:get/get.dart';
import 'package:my_flutter_starter_shell/presentation/screens/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController());
  }

}