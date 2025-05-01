import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/create_visits_controller.dart';

class CreateVisitBinding extends Bindings {
  @override
  void dependencies() {

     Get.lazyPut<CreateVisitController>(() => CreateVisitController());
  }
}