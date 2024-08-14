/*

COMMENT TILE

To use this widget, you need:

- comment
- a function ( e.g. PostMessages() )
- text for button ( e.g. "Save" )

*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/comment.dart';
import '../services/auth/auth_service.dart';
import '../services/database/database_provider.dart';

class MyCommentTile extends StatelessWidget {
  final Comment comment;
  final void Function()? onUserTap;

  const MyCommentTile({
    super.key,
    required this.comment,
    required this.onUserTap,
  });

  void _showOptions(BuildContext context) {
    //check if the comment is owned by the current user
    String currentUid = AuthService().getCurrentUid();
    final bool isOwnComment = comment.uid == currentUid;

    //show bottom options
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                //THIS COMMENT BELONGS TO THE CURRENT USER
                if (isOwnComment)
                  //delete comment button
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text("Delete"),
                    onTap: () async {
                      //pop the option box
                      Navigator.pop(context);

                      //handle delete action
                      await Provider.of<DatabaseProvider>(
                        context,
                        listen: false,
                      ).deleteComment(comment.id, comment.postId);
                    },
                  )

                //THIS COMMENT DOES NOT BELONG TO THE CURRENT USER
                else ...[
                  //report Comment button
                  ListTile(
                    leading: const Icon(Icons.report),
                    title: const Text("Report"),
                    onTap: () {
                      //pop the option box
                      Navigator.pop(context);

                      //handle report action
                      //TODO: report message
                    },
                  ),

                  //block user button
                  ListTile(
                    leading: const Icon(Icons.block),
                    title: const Text("Block User"),
                    onTap: () {
                      //pop the option box
                      Navigator.pop(context);
                    },
                  ),
                ],

                //cancel button
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Cancel"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showOptions(context),
      child: Container(
        //padding outside
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),

        //padding inside
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          //color of the comment tile
          color: Theme.of(context).colorScheme.surface,

          //curve corner
          borderRadius: BorderRadius.circular(12),

          // Add border
          border: Border(
              left: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withOpacity(1), // Adjust color as needed
                width: 2.0,
              ),
              bottom: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withOpacity(1), // Adjust color as needed
                width: 2.0,
              )),
        ),

        //column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Top section : profile picture, name, username
            GestureDetector(
              onTap: onUserTap,
              child: Row(
                children: [
                  //profile picture
                  Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),

                  const SizedBox(width: 20),

                  //name
                  Text(
                    comment.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 5),

                  //username handle
                  Text(
                    '@${comment.username}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const Spacer(),

                  //button -> more options: delete

                  GestureDetector(
                    onTap: () => _showOptions(context),
                    child: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //message
            Text(
              comment.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
