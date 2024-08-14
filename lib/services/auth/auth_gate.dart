import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prism/services/auth/login_or_register.dart';
import '../../pages/home_page.dart';


/* 

AUTH GATE

This is to check if the user is logged in or not

---------------------------------------------------------------------

if the user is logged in, it will go to the home page
if the user is not logged in, it will go to the login page

*/



class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if logged in 
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            //else login
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}