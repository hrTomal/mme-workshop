import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.deviceWidth,
    required this.gapSize,
    required this.description,
  }) : super(key: key);

  final double deviceWidth;
  final double gapSize;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 1,
      padding: EdgeInsets.all(gapSize),
      color: ConstantColors.widgetColor,
      child: Column(
        children: [
          const Text(
            'Assignment Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const WhiteDivider(),
          Text(
            textAlign: TextAlign.justify,
            description ?? '',
          ),
        ],
      ),
    );
  }
}
