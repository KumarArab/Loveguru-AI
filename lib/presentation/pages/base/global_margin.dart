import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlobalMargin extends StatelessWidget {
  const GlobalMargin({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  Container(
width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(24, kIsWeb ? 24 : 0, 24, kIsWeb ? 24 : 0),
      child: child,
    );
  }
}
