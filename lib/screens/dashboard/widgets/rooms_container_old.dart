import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../services/room_data_service.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/constant_widgets.dart';
import '../../live_meeting/meeting_screen.dart';

class RoomsContainer extends StatelessWidget {
  final User userInfo;

  RoomsContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.userInfo,
  }) : super(key: key);

  final double height;
  final double width;
  final Color containerColor = Color.fromRGBO(105, 152, 171, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .45,
      width: width * 1,
      margin: EdgeInsets.all(width * .02),
      decoration: BoxDecoration(
        color: Color.fromRGBO(105, 152, 171, 1),
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoomsWidget(
            width: width,
            height: height,
            userInfo: userInfo,
          ),
          //ActivitesWidget(width: width, height: height)
        ],
      ),
    );
  }
}

class RoomsWidget extends StatefulWidget {
  RoomsWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.userInfo,
  }) : super(key: key);

  final double width;
  final double height;
  final User userInfo;

  @override
  State<RoomsWidget> createState() => _RoomsWidgetState(userInfo);
}

class _RoomsWidgetState extends State<RoomsWidget> {
  final _rooms = MeetingRoomService().getMeetingRooms();

  final User userInfo;

  bool? isAudioOnly = true;

  bool? isAudioMuted = true;

  bool? isVideoMuted = true;

  _RoomsWidgetState(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * .9,
      padding: EdgeInsets.all(widget.height * .01),
      margin: EdgeInsets.symmetric(
          horizontal: widget.width * .01, vertical: widget.height * .01),
      decoration: BoxDecoration(
        color: Color.fromRGBO(26, 55, 77, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Text(
            'Meetings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: widget.width * .1,
          ),
          OutlinedIconButton(
            Buttontext: 'Join Now',
            onPressedFunction: () {},
          ),
          WhiteDivider(),
          Container(
            height: widget.height * .28,
            width: widget.width * .85,
            child: FutureBuilder(
                future: _rooms,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    var _roomList = snapshot.data!.results;
                    return ListView.builder(
                      itemCount: _roomList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _roomList[index].meeting.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: Text(
                                              'Join - ${_roomList[index].meeting.name}'),
                                          content: Column(
                                            children: [
                                              CheckboxListTile(
                                                title: Text("Audio Only"),
                                                value: isAudioOnly,
                                                onChanged: _onAudioOnlyChanged,
                                              ),
                                              const SizedBox(
                                                height: 14.0,
                                              ),
                                              CheckboxListTile(
                                                title: Text("Audio Muted"),
                                                value: isAudioMuted,
                                                onChanged: _onAudioMutedChanged,
                                              ),
                                              const SizedBox(
                                                height: 14.0,
                                              ),
                                              CheckboxListTile(
                                                title: Text("Video Muted"),
                                                value: isVideoMuted,
                                                onChanged: _onVideoMutedChanged,
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                                _navigateToMeeting(
                                                    context,
                                                    '${userInfo.firstName} ${userInfo.lastName}',
                                                    _roomList[index]
                                                        .meeting
                                                        .lobbyName,
                                                    _roomList[index]
                                                        .meeting
                                                        .name);
                                              },
                                              child: Text('Join now'),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  ),
                                  color: Colors.white,
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.indigo,
                            )
                          ],
                        );
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  void _navigateToMeeting(
      BuildContext context, String userName, String lobbyName, String name) {
    //Navigator.pushNamed(context, Meeting.routeName);
    Navigator.pushNamed(
      context,
      Meeting.routeName,
      arguments: MeetingArguments(userName, lobbyName, name),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value;
    });
  }
}
