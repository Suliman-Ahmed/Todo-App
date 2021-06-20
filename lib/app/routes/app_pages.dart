import 'package:get/get.dart';

import 'package:todo_app/app/healper/app_binding.dart';
import 'package:todo_app/app/screens/auth/views/login_page.dart';
import 'package:todo_app/app/screens/home/views/add_task_page.dart';
import 'package:todo_app/app/screens/home/views/home_view.dart';
import 'package:todo_app/app/screens/home/views/control_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CONTROLL_VIEW;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: AppBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => LoginScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: _Paths.CONTROLL_VIEW,
      page: () => ControlView(),
      binding: AppBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TASK,
      page: () => AddTaskPage(),
      binding: AppBinding(),
    ),
  ];
}
