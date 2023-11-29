import 'package:flutter/material.dart';

class AuthNavigationButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String text;
  final double? positionLeft;
  final double? positionRight;
  const AuthNavigationButton({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.text,
    this.positionLeft,
    this.positionRight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: positionLeft,
      right: positionRight,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (positionRight != null) ...[
              Text(text),
              Icon(iconData),
            ] else ...[
              Icon(iconData),
              Text(text),
            ]
          ],
        ),
      ),
    );
  }
}
