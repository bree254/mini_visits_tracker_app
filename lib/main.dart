import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/routes/routes.dart';
import 'core/utils/initial_bindings.dart';
import 'core/utils/size_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        SizeUtils.deviceType = deviceType;
        SizeUtils.orientation = orientation;
        return  GetMaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBindings(),
          initialRoute: AppRoutes.home ,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
