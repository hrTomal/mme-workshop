import 'package:flutter/material.dart';

class alert_image_viewer extends StatelessWidget {
  const alert_image_viewer({
    super.key,
    required this.width,
    required this.height,
    required this.url,
  });

  final double width;
  final double height;
  final String url;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Image.network(
        url,
        fit: BoxFit.contain,
      ),
    );
  }
}
