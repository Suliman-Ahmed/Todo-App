import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/app/healper/firestore_user.dart';
import 'package:todo_app/app/model/user_model.dart';
import 'package:todo_app/app/screens/home/views/control_view.dart';

class AuthController extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;

  late String email, password, name;

  Rxn<User> _user = Rxn<User>();

  User? get user => _user.value;

  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void signOutMethod() async {
    await _auth.signOut();
    Get.offAll(ControlView());
  }

  void signInWithEmailAndPassword(
      {String email = '', String password = ''}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(ControlView());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void createAccountWithEmailAndPassword(
      {String email = '', String password = '', String name = ''}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        this.email = email;
        this.password = password;
        this.name = name;
        saveUser(user);
      });

      Get.offAll(ControlView());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void googleSignInMethod() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print(googleUser);
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    await _auth.signInWithCredential(credential).then((user) {
      saveUser(user, isSocial: true);
      Get.offAll(ControlView());
    });
  }

  void saveUser(UserCredential user, {bool isSocial = false}) async {
    await FireStoreUser().addUserToFireStore(UserModel(
      userId: user.user!.uid,
      email: user.user!.email,
      name: isSocial ? user.user!.displayName : name,
      pic: '',
    ));
  }
}
