import 'package:flutter/material.dart';

/*

USER BIO BOX

This is the box that contains the user's bio

----------------------------------------------------------------------

- text

*/

class MyBioBox extends StatelessWidget {
  final String text;
  const MyBioBox({
    super.key,
    required this.text,
  });

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //container
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      //padding inside
      padding: const EdgeInsets.all(25),

      //padding outside
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),

      //text
      child: Text(
        text.isNotEmpty ? text : 'Add a bio',
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
