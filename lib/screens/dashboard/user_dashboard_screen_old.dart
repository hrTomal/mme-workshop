import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meetingme/models/user.dart';
import 'package:meetingme/screens/dashboard/widgets/dashboard_side_drawer.dart';
import 'package:meetingme/screens/dashboard/widgets/rooms_container.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key, required this.userInfo});

  static const routeName = '/user_dashboard';

  final User userInfo;

  @override
  State<UserDashboard> createState() => _DashboardState(userInfo);
}

class _DashboardState extends State<UserDashboard> {
  final User userInfo;

  _DashboardState(this.userInfo);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('MeetingMe'),
      ),
      drawer: DashboardSideDrawer(
        userInfo: userInfo,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UpcomingEventsContainer(
                height: height,
                width: width,
              ),
              RoomsContainer(
                height: height,
                width: width,
                userInfo: userInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingEventsContainer extends StatelessWidget {
  const UpcomingEventsContainer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .4,
      width: width * 1,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(105, 152, 171, 1),
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width * .9,
            decoration: BoxDecoration(
              color: Color.fromRGBO(26, 55, 77, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    'Upcoming Events',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: height * .325,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Eventcard(height: height),
                        Eventcard(height: height),
                        Eventcard(height: height),
                        Eventcard(height: height),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Container(
          //   width: width * .3,
          //   color: Color.fromRGBO(26, 55, 77, 1),
          //   margin: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const Text(
          //         'Calendar View',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.calendar_month_outlined,
          //             color: Colors.white,
          //           ))
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class Eventcard extends StatelessWidget {
  const Eventcard({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.blueGrey,
      child: Container(
        height: height * .1,
        child: Row(
          children: [
            Container(
              width: width * .17,
              height: height * .09,
              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(26, 55, 77, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                '14 Oct',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              width: width * .65,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromRGBO(26, 55, 77, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: const [
                  Text(
                    '9.00 AM To 12.PM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Text(
                    'Course Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActivitesWidget extends StatelessWidget {
  const ActivitesWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(height * .01),
      width: width * .45,
      margin:
          EdgeInsets.symmetric(horizontal: width * .01, vertical: height * .01),
      decoration: BoxDecoration(
        color: Color.fromRGBO(26, 55, 77, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: const [
          Text(
            'Activities',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
