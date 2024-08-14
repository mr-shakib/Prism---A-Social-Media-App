/*

ACCOIUNT SETTINGS PAGE


*/

import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  //ask the user if they are sure they want to delete their account
  void confirmDeletion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to delete your account?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              //delete user account
              await AuthService().deleteAccount();

              //go back to login page
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      //App Bar
      appBar: AppBar(
        title: const Text("Account Settings"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      //Body
      body: Column(
        children: [
          // delete tile
          GestureDetector(
            onTap: () => confirmDeletion(context),
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              width: MediaQuery.of(context).size.width -
                  50, // full width minus the margin
              child: Center(
                child: Text(
                  "Delete Account",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
