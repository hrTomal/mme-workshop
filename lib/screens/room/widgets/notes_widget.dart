import 'package:flutter/material.dart';

class NotesWidget extends StatelessWidget {
  const NotesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text('Notes'),
    );
  }
}
