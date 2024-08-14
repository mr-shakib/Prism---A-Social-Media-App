import 'package:flutter/material.dart';

class MyFollowButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isFollowing;
  const MyFollowButton({
    super.key,
    required this.onPressed,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isFollowing
                  ? [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ]
                  : [
                Colors.deepPurple,
                Colors.deepOrange.shade300,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: MaterialButton(
            padding: const EdgeInsets.all(15.0),
            onPressed: onPressed,
            child: Text(
              isFollowing ? "Unfollow" : "Follow",
              style: TextStyle(

                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}