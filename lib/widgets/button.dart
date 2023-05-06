import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
