import 'package:flutter/material.dart';

class StandartCustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Size? minumalSize;
  const StandartCustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.minumalSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(minumalSize),
      ),
      child: Text(label),
    );
  }
}
