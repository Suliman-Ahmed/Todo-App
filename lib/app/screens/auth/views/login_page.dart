import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/widgets/custom_text_form_field.dart';

import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  var authController = Get.put(AuthController());
  bool isObscured = false;

  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 120.0,
      child: Image.asset('images/logo.png'),
    ),
  );

  final forgotLabel = MaterialButton(
    child: Text(
      'Forgot password?',
      style: TextStyle(color: Colors.black54),
    ),
    onPressed: () {},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DefaultTabController(
          length: 2,
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 48.0),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.3),
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.blueAccent,
                    labelStyle: TextStyle(fontSize: 16),
                    labelPadding: EdgeInsets.only(bottom: 10),
                    tabs: [
                      Text('Login'),
                      Text('Sign UP'),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  margin: EdgeInsets.only(top: 50),
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      loginForm(),
                      signUpForm(),
                    ],
                  ),
                ),
                googleSignInMethod(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  googleSignInMethod() => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            authController.googleSignInMethod();
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(FontAwesomeIcons.google, color: Colors.white),
              Text('Google', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );

  Widget loginButton({String text = '', fun}) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
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

  Widget loginForm() {
    return Container(
      child: Column(
        children: [
          ////////////////////////////////////////////////////////////////
          /// Email
          CustomTextFormField(
            controller: _emailController,
            hintText: 'example@gmail.com',
            labelText: 'Email',
            textInputType: TextInputType.text,
            labelStyle: TextStyle(color: Colors.blueAccent),
          ),
          SizedBox(height: 8.0),
          ////////////////////////////////////////////////////////////////
          /// Password
          CustomTextFormField(
            controller: _passController,
            hintText: '********',
            labelText: 'Password',
            textInputType: TextInputType.text,
            obscured: isObscured,
            labelStyle: TextStyle(color: Colors.blueAccent),
            suffixIcon: IconButton(
              icon: Icon(
                isObscured ? FeatherIcons.eye : FeatherIcons.eyeOff,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                setState(() {
                  isObscured = !isObscured;
                });
              },
            ),
          ),
          SizedBox(height: 24.0),
          loginButton(
              text: 'Login',
              fun: () {
                authController.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passController.text);
              }),
          forgotLabel,
        ],
      ),
    );
  }

  Widget signUpForm() {
    return Container(
      child: Column(
        children: [
          ////////////////////////////////////////////////////////////////
          /// Name
          CustomTextFormField(
            controller: _nameController,
            hintText: 'John',
            labelText: 'Username',
            textInputType: TextInputType.text,
            labelStyle: TextStyle(color: Colors.blueAccent),
          ),
          SizedBox(height: 8.0),
          ////////////////////////////////////////////////////////////////
          /// Email
          CustomTextFormField(
            controller: _emailController,
            hintText: 'example@gmail.com',
            labelText: 'Email',
            textInputType: TextInputType.emailAddress,
            labelStyle: TextStyle(color: Colors.blueAccent),
          ),
          SizedBox(height: 8.0),
          ////////////////////////////////////////////////////////////////
          /// Password
          CustomTextFormField(
            controller: _passController,
            hintText: '********',
            labelText: 'Password',
            textInputType: TextInputType.text,
            obscured: isObscured,
            labelStyle: TextStyle(color: Colors.blueAccent),
            suffixIcon: IconButton(
              icon: Icon(
                isObscured ? FeatherIcons.eye : FeatherIcons.eyeOff,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                setState(() {
                  isObscured = !isObscured;
                });
              },
            ),
          ),
          SizedBox(height: 24.0),
          loginButton(
              text: 'Sign up',
              fun: () {
                authController.createAccountWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passController.text,
                    name: _nameController.text);
              }),
        ],
      ),
    );
  }
}
