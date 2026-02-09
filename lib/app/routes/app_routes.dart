import 'package:get/get.dart';
import 'package:turningdemo/App/routes/routes_name.dart';

import 'package:turningdemo/app/feature/home/screen/home_dashboard_screen.dart';
import '../feature/auth/screens/resister_page.dart';
import '../feature/auth/screens/login_page.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: RoutesName.register,
      page: () => ResisterPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RoutesName.login,
      page: () => LoginPage(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.home,
      page: () => HomeDashboardScreen(),
      transition: Transition.leftToRight,
    ),
  ];
}
