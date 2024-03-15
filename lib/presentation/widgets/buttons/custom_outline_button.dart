import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({super.key, required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                side: const BorderSide(
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
            child: child,
          ),
        ),
      ],
    );
  }
}
