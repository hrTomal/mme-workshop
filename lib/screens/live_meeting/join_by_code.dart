import 'package:flutter/material.dart';
import 'package:meetingme/components/components.dart';
import 'package:meetingme/screens/live_meeting/meeting_webview.dart';

import '../../constants/colors.dart';
import '../../widgets/constant_widgets.dart';

class JoinMeetingByCode extends StatefulWidget {
  const JoinMeetingByCode({super.key});

  static const routeName = 'join_meeting_by_code';

  @override
  State<JoinMeetingByCode> createState() => _JoinMeetingByCodeState();
}

class _JoinMeetingByCodeState extends State<JoinMeetingByCode> {
  var meetingCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Join By Code')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * .125),
              child: TextFieldContainer(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: meetingCode,
                  decoration: roundedInputFieldDecoration.copyWith(
                    hintText: "Meeting Code",
                    icon: const Icon(Icons.lock),
                    counterText: '',
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MeetingWebview.routeName,
                    arguments: meetingCode.text);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ConstantColors.primaryColor, // text color
              ),
              child: const Text('Join'),
            )
          ],
        ),
      ),
    );
  }
}
