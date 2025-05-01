import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_flutter_starter_shell/presentation/screens/home/binding/home_binding.dart';
import 'package:my_flutter_starter_shell/presentation/screens/home/home_screen.dart';
import 'package:my_flutter_starter_shell/presentation/screens/vists/create_visit.dart';

class AppRoutes {
  static const String home = '/home';
  static const String visists = '/visit';

  static List<GetPage> pages = [
    GetPage(
        name: home,
        page: (){
      return HomeScreen();
    },
      binding: HomeBinding(),
    ),
    GetPage(
        name: visists,
        page: (){
          return CreateVisit();
        },
      binding: HomeBinding(),
    ),
  ];
}