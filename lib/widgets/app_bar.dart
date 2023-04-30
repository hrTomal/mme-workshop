import 'package:flutter/material.dart';
import 'package:meetingme/models/user.dart';

class MMEAppBar extends StatelessWidget {
  const MMEAppBar({
    super.key,
    required this.topSectionHeight,
    required this.width,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.height,
    required this.userInfo,
    required this.userVerification,
  }) : _scaffoldKey = scaffoldKey;

  final double topSectionHeight;
  final double width;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final double height;
  final User userInfo;
  final bool userVerification;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: topSectionHeight,
      padding: EdgeInsets.symmetric(horizontal: width * .03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(Icons.line_weight),
                color: Colors.white,
              ),
              const VerticalDivider(),
              Text(
                'Meeting Me',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: height * .03),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                child: Text(
                  '${userInfo.firstName} ${userInfo.lastName}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                child: Icon(
                  Icons.verified_user,
                  color: userVerification ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
