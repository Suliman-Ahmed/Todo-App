import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/screens/home/controllers/home_controller.dart';

class AddTaskPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  void clearFields() {
    _nameController.text = '';
    _descriptionController.text = '';
    _durationController.text = '';
  }

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding Task Page'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,          
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Add Task Title',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Add Task Description',
              ),
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                hintText: 'Add Task Duration',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                loginButton(
                    text: 'Add Task',
                    fun: () {
                      controller.addTask(
                          _nameController.text,
                          _durationController.text,
                          _descriptionController.text);
                      Get.back();
                    }),
                loginButton(text: 'Empty Fields', fun: clearFields),
              ],
            ),
          ],
        ),
      ),
    );
  }

  loginButton({String text = '', fun}) {
    return Container(
      width: 125,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: fun,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
