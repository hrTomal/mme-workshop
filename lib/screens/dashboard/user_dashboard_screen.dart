import 'package:flutter/material.dart';
import 'package:meetingme/screens/dashboard/widgets/dashboard_image_carousel.dart';
import 'package:meetingme/screens/dashboard/widgets/dashboard_side_drawer.dart';
import 'package:meetingme/screens/dashboard/widgets/notice_widget.dart';
import 'package:meetingme/screens/dashboard/widgets/rooms_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/user.dart';
import '../../services/room_data_service.dart';
import '../live_meeting/meeting_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key, required this.userInfo});

  static const routeName = '/user_dashboard';
  final User userInfo;

  @override
  State<UserDashboard> createState() => _UserDashboardState(userInfo);
}

class _UserDashboardState extends State<UserDashboard>
    with SingleTickerProviderStateMixin {
  final User userInfo;
  late TabController _controller;

  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  _UserDashboardState(this.userInfo);

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final topSectionHeight = height * .10;
    final userVerification = userInfo.isActive ?? false;
    final _rooms = RoomService().getRooms();
    final meetings = MeetingRoomService().getMeetingRooms();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color.fromRGBO(26, 55, 77, 1),
          drawer: SideDrawerForAllPage(
            userInfo: userInfo,
          ),
          body: Column(
            children: [
              Container(
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
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(width * .025),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(width * .05),
                      topLeft: Radius.circular(width * .05),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: (height - topSectionHeight) * .65,
                        color: Colors.white,
                        child: ListView(
                          children: [
                            TabBar(
                              labelColor: Color.fromARGB(255, 71, 88, 95),
                              automaticIndicatorColorAdjustment: true,
                              controller: _controller,
                              tabs: const [
                                Tab(
                                  icon: Icon(
                                    Icons.calendar_month,
                                  ),
                                  text: 'Schedule',
                                ),
                                Tab(
                                  icon: Icon(Icons.notifications_none_outlined),
                                  text: 'Notices',
                                ),
                              ],
                            ),
                            Container(
                              height: (height - topSectionHeight) * .52,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 242, 255),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(width * .03),
                                ),
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Color.fromARGB(255, 232, 242, 255),
                                //     spreadRadius: 3,
                                //     blurRadius: 5,
                                //     offset: Offset(
                                //         3, 3), // changes position of shadow
                                //   ),
                                //],
                              ),
                              child: TabBarView(
                                controller: _controller,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(height * .012),
                                    child: FutureBuilder(
                                      future: meetings,
                                      builder: ((context, snapshot) {
                                        if (snapshot.hasData) {
                                          return SfCalendar(
                                            view: CalendarView.month,
                                            allowedViews: const [
                                              CalendarView.day,
                                              CalendarView.week,
                                              CalendarView.workWeek,
                                              CalendarView.month,
                                              CalendarView.timelineDay,
                                              CalendarView.timelineWeek,
                                              CalendarView.timelineWorkWeek,
                                            ],
                                            dataSource: MeetingDataSource(
                                              _getMeetings(
                                                snapshot,
                                                userInfo,
                                              ),
                                            ),
                                            monthViewSettings:
                                                MonthViewSettings(
                                              showAgenda: false,
                                              agendaViewHeight: height * .1,
                                            ),
                                            showNavigationArrow: true,
                                            onTap: calendarTapped,
                                          );
                                        } else {
                                          return SfCalendar(
                                            view: CalendarView.month,
                                            allowedViews: const [
                                              CalendarView.day,
                                              CalendarView.week,
                                              CalendarView.workWeek,
                                              CalendarView.month,
                                              CalendarView.timelineDay,
                                              CalendarView.timelineWeek,
                                              CalendarView.timelineWorkWeek,
                                            ],
                                            showNavigationArrow: true,
                                          );
                                        }
                                      }),
                                    ),
                                  ),
                                  NoticeWidget(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(
                      //   height: (height - topSectionHeight) * .002,
                      // ),

                      //After the Calendar
                      Container(
                        height: (height - topSectionHeight) * .28,
                        child: Column(
                          children: [
                            // Container(
                            //   height: (height - topSectionHeight) * .24 * .2,
                            //   decoration: const BoxDecoration(
                            //     color: Color.fromARGB(255, 232, 242, 255),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Color.fromARGB(255, 232, 255, 255),
                            //         spreadRadius: 2,
                            //         blurRadius: 3,
                            //         offset: Offset(
                            //             0, 3), // changes position of shadow
                            //       ),
                            //     ],
                            //   ),
                            //   child: const Center(
                            //     child: Text(
                            //       'My Rooms',
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            RoomsWidget(
                              width: width,
                              rooms: _rooms,
                              height: height,
                              topSectionHeight: topSectionHeight,
                            ),
                            DashboardImageCarousel(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.appointments!.length != 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Container(
              height: MediaQuery.of(context).size.height * .5,
              width: 500,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: details.appointments!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(details.appointments![index].eventName),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Text(
                                    'Join - ${details.appointments![index].name}'),
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
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      _navigateToMeeting(
                                          context,
                                          details.appointments![index].userName,
                                          details
                                              .appointments![index].lobbyName,
                                          details.appointments![index].name);
                                    },
                                    child: Text('Join now'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.arrow_forward),
                      )
                    ],
                  ));
                },
              ),
            ),
          );
        },
      );
    }
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

_getMeetings(values, userInfo) {
  //final rooms = MeetingRoomService().getMeetingRooms();
  final List<SingleMeeting> meetings = <SingleMeeting>[];

  values.data.results?.forEach(
    (element) {
      DateTime meetingDate = DateTime.parse(element.meeting!.date);
      DateTime startTimeFull = DateTime.parse(
          element.meeting!.date + ' ' + element.meeting!.startTime);
      DateTime endTimeFull = DateTime.parse(
          (element.meeting!.date) + ' ' + element.meeting!.endTime);

      DateTime startTime = DateTime(
          meetingDate.year,
          meetingDate.month,
          meetingDate.day,
          startTimeFull.hour,
          startTimeFull.minute,
          startTimeFull.second);

      DateTime endTime = DateTime(
          meetingDate.year,
          meetingDate.month,
          meetingDate.day,
          endTimeFull.hour,
          endTimeFull.minute,
          endTimeFull.second);

      var userName = '${userInfo.firstName} ${userInfo.lastName}';
      var lobbyName = element.meeting!.lobbyName;
      var name = element.meeting!.name;

      meetings.add(
        SingleMeeting(
          element.meeting!.name ?? '',
          startTime,
          endTime,
          const Color.fromRGBO(0, 29, 51, 1),
          false,
          userName,
          lobbyName,
          name,
        ),
      );
    },
  );

  return meetings;
}

void _navigateToMeeting(
    BuildContext context, String userName, String lobbyName, String name) {
  Navigator.pushNamed(
    context,
    Meeting.routeName,
    arguments: MeetingArguments(userName, lobbyName, name),
  );
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<SingleMeeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class SingleMeeting {
  SingleMeeting(this.eventName, this.from, this.to, this.background,
      this.isAllDay, this.userName, this.lobbyName, this.name);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String userName;
  String lobbyName;
  String name;
}
