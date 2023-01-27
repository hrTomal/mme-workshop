import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/screens/fees/payment_history.dart';
import 'package:meetingme/screens/login/login_screen.dart';
import 'package:meetingme/screens/splash/splash_screen.dart';

import '../../../models/user.dart';
import '../../../widgets/constant_widgets.dart';
import '../../fees/fees_screeen.dart';

class SideDrawerForAllPage extends StatelessWidget {
  const SideDrawerForAllPage({super.key, required this.userInfo});

  final User userInfo;

  @override
  Widget build(BuildContext context) {
    return DashboardSideDrawer(
      userInfo: userInfo,
    );
  }
}

class DashboardSideDrawer extends StatefulWidget {
  DashboardSideDrawer({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  final User userInfo;

  @override
  State<DashboardSideDrawer> createState() =>
      _DashboardSideDrawerState(userInfo);
}

class _DashboardSideDrawerState extends State<DashboardSideDrawer> {
  final User userInfo;

  _DashboardSideDrawerState(this.userInfo);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.blueGrey,
      width: width * .7,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(26, 55, 77, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: width * .11,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  child: Text(
                    '${userInfo.firstName} ${userInfo.lastName}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: const Text(
              "Payment",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            childrenPadding: const EdgeInsets.only(
              left: 60,
            ),
            children: [
              ListTile(
                title: const Text(
                  'Payable',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: (() {
                  Navigator.pushNamed(
                    context,
                    Fees.routeName,
                  );
                }),
              ),
              ListTile(
                title: const Text(
                  'Payment History',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: (() {
                  Navigator.pushNamed(
                    context,
                    PaymentHistory.routeName,
                  );
                }),
              ),
            ],
          ),
          const WhiteDivider(),
          ListTile(
            title: const Text(
              'My Rooms',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: (() {}),
          ),
          const WhiteDivider(),
          ListTile(
            title: const Text(
              'Contact Us',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: (() {}),
          ),
          const WhiteDivider(),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: (() {
              _logout(context);
            }),
          )
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await SessionManager().destroy();
    Navigator.pushNamed(context, LoginScreen.routeName);
  }
}
