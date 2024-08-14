/*

USER LIST TILE
================

*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prism/models/user.dart';

import '../screens/profile_screen.dart';

class MyUserTile extends StatelessWidget {
  final UserProfile user;
  const MyUserTile({
    super.key,
    required this.user,
  });

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //container
    return Container(
      //padding outside
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),

      //padding inside
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,

        //curve corner
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        //Name
        title: Text(user.name),
        titleTextStyle:
            TextStyle(color: Theme.of(context).colorScheme.inversePrimary),

        //username
        subtitle: Text('@${user.username}'),
        subtitleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),

        //profile pic
        leading: Icon(
          Icons.person,
          color: Theme.of(context).colorScheme.primary,
        ),

        //on tap
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              uid: user.uid,
            ),
          ),
        ),

        //visit icon
        trailing: Icon(CupertinoIcons.arrow_right,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
