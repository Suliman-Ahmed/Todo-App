import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var _user;

  late Stream<QuerySnapshot> stream;
  var name = ''.obs;

  var collectionRefrence;

  void getUserName() {
    var documents =
        FirebaseFirestore.instance.collection('Users').doc(_user.uid);

    documents.get().then((document) {
      name.value = _user.displayName ?? document["name"];
      update();
    });
  }

  @override
  void onInit() {
    _user = FirebaseAuth.instance.currentUser;
    collectionRefrence = FirebaseFirestore.instance
        .collection('User Todo')
        .doc('UserTask')
        .collection(_user!.uid);
    stream = collectionRefrence.snapshots();
    getUserName();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getUserName();
  }

  void deleteFun(document) {
    collectionRefrence.doc(document.id).delete();
  }

  void updateFun(document, List<String> fields, List<String> updateData) {
    for (var i = 0; i < fields.length; i++)
      collectionRefrence.doc(document.id).update({fields[i]: updateData[i]});
  }

  void addTask(String title, String duration, String description) async {
    collectionRefrence
        .add({'title': title, 'dur': duration, 'des': description});
  }

  showSheet(document, {name, dur, des}) async {
    List<String> fields = ['title', 'dur', 'des'];
    name.text = document.get('title');
    dur.text = document.get('dur');
    des.text = document.get('des');

    return showDialog(
        context: Get.overlayContext as BuildContext,
        builder: (context) {
          return AlertDialog(
            title: Text('Update Title'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _textField(name, 'Add Task Title'),
                _textField(des, 'Add Task Description'),
                _textField(dur, 'Add Task Duration'),
              ],
            ),
            actions: [
              Container(
                width: 125,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: () {
                    List<String> updateData = [name.text, dur.text, des.text];
                    updateFun(document, fields, updateData);
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.all(12),
                  color: Colors.lightBlueAccent,
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                width: 125,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.all(12),
                  color: Colors.lightBlueAccent,
                  child: Text('Cancel', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          );
        });
  }

  TextField _textField(controller, hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }

  @override
  void onClose() {}
}
