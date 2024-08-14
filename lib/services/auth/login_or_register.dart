import 'package:flutter/material.dart';
import 'package:prism/pages/login_page.dart';
import 'package:prism/pages/register_page.dart';

/* 

LOGIN OR REGISTER PAGE

This page is used to either go to the login page or the register page

---------------------------------------------------------------------

To use this widget, you need: 

- LoginOrRegister()


*/

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login and register
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
