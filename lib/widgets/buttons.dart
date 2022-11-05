import 'package:flutter/material.dart';

class OutlinedIconButton extends StatelessWidget {
  final String Buttontext;
  final Function onPressedFunction;

  const OutlinedIconButton({
    Key? key,
    required this.Buttontext,
    required this.onPressedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressedFunction(),
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      label: Text(
        Buttontext,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 1.5, color: Colors.white),
      ),
    );
  }
}
