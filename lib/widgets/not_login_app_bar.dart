import 'package:flutter/material.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/screens/live_meeting/join_by_code.dart';
import 'package:meetingme/screens/login/login_screen.dart';

class MMEAppBarNotLoggedIn extends StatelessWidget {
  const MMEAppBarNotLoggedIn({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final topSectionHeight = height * .10;
    return Container(
      height: topSectionHeight,
      padding: EdgeInsets.symmetric(horizontal: width * .03),
      color: ConstantColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // IconButton(
              //   onPressed: () {
              //     _scaffoldKey.currentState?.openDrawer();
              //   },
              //   icon: Icon(Icons.line_weight),
              //   color: Colors.white,
              // ),
              // const VerticalDivider(),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Meeting Me',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: height * .03),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, JoinMeetingByCode.routeName);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: ConstantColors.meetingButtonColor, // text color
            ),
            child: const Text(
              'Join Meeting',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text('Login'),
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       child: Text(
          //         '${userInfo.firstName} ${userInfo.lastName}',
          //         style: const TextStyle(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       child: Icon(
          //         Icons.verified_user,
          //         color: userVerification ? Colors.green : Colors.red,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
