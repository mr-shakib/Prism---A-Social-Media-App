import 'package:flutter/material.dart';

/* 

LOADING CIRCLE

*/

//showing loading circle

void showLoadingCircle(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

//hide loading circle

void hideLoadingCircle(BuildContext context) {
  Navigator.of(context).pop();
}
