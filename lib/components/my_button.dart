import 'package:flutter/material.dart';

/* 

BUTTON

----------------------------------

To use this ,we need:

- text
- function (on tap)

*/
class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //padding inside
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          // Apply a gradient to the button background
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.deepPurple
            ], // Adjust colors as needed
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),

        //text
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color:
                Colors.white, // Ensure the text is visible against the gradient
          ),
        )),
      ),
    );
  }
}
