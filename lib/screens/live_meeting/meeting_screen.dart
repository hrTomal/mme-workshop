import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../../constants/urls.dart';

class Meeting extends StatefulWidget {
  static const routeName = '/meeting_screen';

  final String userName;
  final String lobbyName;
  final String name;

  const Meeting({
    super.key,
    required this.userName,
    required this.lobbyName,
    required this.name,
  });

  @override
  State<Meeting> createState() => _MeetingState(userName, lobbyName, name);
}

class _MeetingState extends State<Meeting> {
  final String lobbyName;
  final String userName;
  final String code;

  late final serverText;
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  _MeetingState(this.userName, this.lobbyName, this.code) {
    this.serverText = APIurls.meetingServerUrl + this.code;
  }

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(
      JitsiMeetingListener(
          onConferenceWillJoin: _onConferenceWillJoin,
          onConferenceJoined: _onConferenceJoined,
          onConferenceTerminated: _onConferenceTerminated,
          onError: _onError),
    );
    _joinMeeting(
      this.serverText,
      this.lobbyName,
      '',
      this.userName,
      '',
      '',
      true,
      true,
      true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 16.0,
        // ),
        child: kIsWeb
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   width: width * 0.30,
                  //   child: meetConfig(context),
                  // ),
                  Container(
                      width: width * 0.60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            color: Colors.white54,
                            child: SizedBox(
                              width: width * 0.60 * 0.70,
                              height: width * 0.60 * 0.70,
                              child: JitsiMeetConferencing(
                                extraJS: const [
                                  // extraJs setup example
                                  '<script>function echo(){console.log("echo!!!")};</script>',
                                  '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                                ],
                              ),
                            )),
                      ))
                ],
              )
            : meetConfig(context),
      ),
    );
  }
}

Widget meetConfig(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Meeting Terminated'),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Return to Dashboard'),
        )
      ],
    ),
  );
}

class MeetingArguments {
  final String userName;
  final String lobbyName;
  final String name;

  MeetingArguments(
    this.userName,
    this.lobbyName,
    this.name,
  );
}

_joinMeeting(
  String serverText,
  String roomText,
  String subjectText,
  String nameText,
  String emailText,
  String iosAppBarRGBAColor,
  bool isAudioOnly,
  bool isAudioMuted,
  bool isVideoMuted,
) async {
  String? serverUrl = serverText;

  // Enable or disable any feature flag here
  // If feature flag are not provided, default values will be used
  // Full list of feature flags (and defaults) available in the README
  Map<FeatureFlagEnum, bool> featureFlags = {
    FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
  };
  if (!kIsWeb) {
    // Here is an example, disabling features for each platform
    if (Platform.isAndroid) {
      // Disable ConnectionService usage on Android to avoid issues (see README)
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      featureFlags[FeatureFlagEnum.RECORDING_ENABLED] = false;
    } else if (Platform.isIOS) {
      // Disable PIP on iOS as it looks weird
      featureFlags[FeatureFlagEnum.RECORDING_ENABLED] = false;
      featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    }
  }
  // Define meetings options here
  var options = JitsiMeetingOptions(room: roomText)
    ..serverURL = serverUrl
    ..subject = subjectText
    ..userDisplayName = nameText
    ..userEmail = emailText
    ..iosAppBarRGBAColor = iosAppBarRGBAColor
    ..audioOnly = isAudioOnly
    ..audioMuted = isAudioMuted
    ..videoMuted = isVideoMuted
    ..featureFlags.addAll(featureFlags)
    ..webOptions = {
      "roomName": roomText,
      "width": "100%",
      "height": "100%",
      "enableWelcomePage": false,
      "chromeExtensionBanner": null,
      "userInfo": {"displayName": nameText}
    };

  //debugPrint("JitsiMeetingOptions: $options");
  await JitsiMeet.joinMeeting(
    options,
    listener: JitsiMeetingListener(
        onConferenceWillJoin: (message) {
          debugPrint("${options.room} will join with message: $message");
        },
        onConferenceJoined: (message) {
          debugPrint("${options.room} joined with message: $message");
        },
        onConferenceTerminated: (message) {
          debugPrint("${options.room} terminated with message: $message");
        },
        genericListeners: [
          JitsiGenericListener(
              eventName: 'readyToClose',
              callback: (dynamic message) {
                debugPrint("readyToClose callback");
              }),
        ]),
  );
}

void _onConferenceWillJoin(message) {
  debugPrint("_onConferenceWillJoin broadcasted with message: $message");
}

void _onConferenceJoined(message) {
  debugPrint("_onConferenceJoined broadcasted with message: $message");
}

void _onConferenceTerminated(message) {
  debugPrint("_onConferenceTerminated broadcasted with message: $message");

  AlertDialog(
    title: const Text('Error'),
    content: Text('dddd'),
    actions: <Widget>[
      ElevatedButton(
        child: const Text('Close me!'),
        onPressed: () {
          //Navigator.pop(context);
        },
      )
    ],
  );
}

_onError(error) {
  debugPrint("_onError broadcasted: $error");
}
