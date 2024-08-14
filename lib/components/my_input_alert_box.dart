import 'package:flutter/material.dart';

/*

INPUT ALERT BOX

This is an alert dialog box that has a textfield where the user can type in. We
will use this for things like editing bio, posting new message etc.

--------------------------------------------------------------------

TO use this widget, you need:
- text controller ( to access what the user typed )
- hint text ( e.g. "What's on your mind" )
- a function ( e.g. PostMessages() )
- text for button ( e.g. "Save" )

*/

class MyInputAlertBox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final void Function()? onPressed;
  final String onPressedText;
  const MyInputAlertBox({
    super.key,
    required this.textController,
    required this.hintText,
    required this.onPressed,
    required this.onPressedText,
  });

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //curve corner
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),

      //color
      backgroundColor: Theme.of(context).colorScheme.surface,

      //text
      content: TextField(
        controller: textController,

        //max length

        maxLines: 6,
        decoration: InputDecoration(
          //border when text field in not selected
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
            borderRadius: BorderRadius.circular(12),
          ),

          //norder when text field is selected
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(12),
          ),

          //hint text
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),

          //color inside of textfield
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,

          //counter style
          counterStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //cancel button
            TextButton(
              onPressed: () {
                //close box
                Navigator.pop(context);

                //clear controller
                textController.clear();
              },
              child: const Text("Cancel"),
            ),

            //yes button
            TextButton(
              onPressed: () {
                //close box
                Navigator.pop(context);

                //execute function
                onPressed!();

                //clear controller
                textController.clear();
              },
              child: Text(onPressedText),
            ),
          ],
        )
      ],
    );
  }
}
