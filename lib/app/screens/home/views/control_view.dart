import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/screens/auth/controllers/auth_controller.dart';
import 'package:todo_app/app/screens/auth/views/login_page.dart';
import 'package:todo_app/app/screens/home/views/home_view.dart';

class ControlView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (controller.user == null)
          ? LoginScreen()
          : HomeView();
    });
  }
}
