import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prism/components/my_settings_tile.dart';
import 'package:prism/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // Dark Mode

          MySettingsTile(
            title: "Dark Mode",
            action: CupertinoSwitch(
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
            ),
          )

          // Blocked Users
          // Account Settings
        ],
      ),
    );
  }
}
