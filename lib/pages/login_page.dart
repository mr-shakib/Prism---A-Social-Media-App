import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prism/components/my_button.dart';
import 'package:prism/components/my_loading_circle.dart';
import 'package:prism/components/my_text-field.dart';
import 'package:prism/services/auth/auth_service.dart';

/*

LOGIN PAGE

On this page, an existing user can login with their:

- email
- password

-----------------------------------------------------

Or they can go  to the rgister page to create a new account
*/

class LoginPage extends StatefulWidget {
  final void Function() onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //access auth service
  final _auth = AuthService();

  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  //login method
  void login() async {
    // show loading circle
    showLoadingCircle(context);

    //attempt to login
    try {
      await _auth.loginEmailPassword(emailController.text, pwController.text);

      //finished loading
      if (mounted) hideLoadingCircle(context);
    }

    //catch any errors
    catch (e) {
      //finished loading
      if (mounted) hideLoadingCircle(context);

      //let the user know
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            "Invalid Credintials",
          ),
        ),
      );
      print(e.toString());
    }
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      //body
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  // app logo
                  Lottie.network(
                    'https://lottie.host/10998f8b-f6cc-4ae7-83f1-98816d85dc66/JXD8EkvyO8.json',
                    height: 350,
                  ),

                  const SizedBox(height: 10),

                  //welcome back message
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      "Hey Prismer, welcome back!",
                      style: TextStyle(
                        color: Colors
                            .white, // The color here won't matter as the shader will override it
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  //email field
                  MyTextField(
                      icon: Icons.email,
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false),

                  const SizedBox(height: 15),

                  //password field
                  MyTextField(
                      icon: Icons.password,
                      controller: pwController,
                      hintText: "Password",
                      obscureText: true),

                  const SizedBox(height: 15),

                  //forgot password

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  //login button
                  MyButton(
                    text: "Login",
                    onTap: login,
                  ),

                  const SizedBox(height: 50),

                  //register button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a prismer?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(width: 5),

                      //user can tap here to go to register page
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
