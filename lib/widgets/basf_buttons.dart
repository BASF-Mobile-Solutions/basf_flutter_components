import 'package:flutter/material.dart';

class BASFButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const BASFButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        maximumSize: const Size(double.infinity, 48),
        backgroundColor: Colors.blue, // ! AppColors.basfBlue,
        shape: const ContinuousRectangleBorder(),
        textStyle: const TextStyle(color: Colors.white),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
