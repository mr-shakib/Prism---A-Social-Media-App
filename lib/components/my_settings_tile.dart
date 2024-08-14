import 'package:flutter/material.dart';

/* 

SETTINGS LIST TILE

This is a simple tile for each item in the settings page

-----------------------------------------------------------------

To use this widget, you need:

- title ( e.g. "Dark Mode")
- action (e.g. toggleTheme() )

*/

class MySettingsTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget? action;
  final VoidCallback? onTap;

  const MySettingsTile({
    super.key,
    required this.title,
    this.icon,
    this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //Container for the tile
    return InkWell(
      onTap: onTap, // Add the onTap callback here
      child: Container(
        decoration: BoxDecoration(
          //color
          color: Theme.of(context).colorScheme.secondary,

          //curve corner
          borderRadius: BorderRadius.circular(12),
        ),

        //padding inside
        margin: EdgeInsets.only(left: 25, right: 25, top: 10),

        //padding outisde
        padding: const EdgeInsets.all(25),

        //row
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (icon != null) ...[
              SizedBox(width: 10), // Add space between text and icon
              Icon(icon,
                  color: Theme.of(context)
                      .colorScheme
                      .primary), // Show icon if it's not null
            ],
            if (action != null) ...[
              SizedBox(width: 10), // Add space between icon and action (if any)
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
