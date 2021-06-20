import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/screens/auth/controllers/auth_controller.dart';
import 'package:todo_app/app/screens/home/views/add_task_page.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _duration = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('${controller.name}')),
        actions: [
          IconButton(
              onPressed: () async {
                authController.signOutMethod();
              },
              icon: Icon(Icons.power_settings_new_outlined)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((QueryDocumentSnapshot document) {
              return ListTile(
                onTap: () => controller.showSheet(
                  document,
                  name: _title,
                  des: _description,
                  dur: _duration,
                ),
                title: Text(document.get('title') as String),
                subtitle: Row(
                  children: [
                    Text(document.get('dur') as String),
                    Spacer(),
                    Text(document.get('des') as String),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => controller.deleteFun(document),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddTaskPage());
        },
      ),
    );
  }
}
