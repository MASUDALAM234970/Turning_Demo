import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:turningdemo/App/routes/app_routes.dart';
import 'package:turningdemo/App/routes/routes_name.dart';
import 'package:turningdemo/app/core/binding/apps_binding.dart';

void main() {
  runApp(const MyApp());
  print("Hello bangladesh");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.login,
      getPages: AppRoutes.pages,
      initialBinding: AppsBinding(),
    );
  }
}
