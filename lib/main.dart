import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:meetingme/bloc/login/login_bloc.dart';
import 'package:meetingme/bloc/login/login_state.dart';
import 'package:meetingme/bloc/tasks/notes/notes_bloc.dart';
import 'package:meetingme/bloc/tasks/notes/notes_state.dart';
import 'package:meetingme/models/room_info.dart';
import 'package:meetingme/models/tasks/assignments.dart';
import 'package:meetingme/models/user.dart';
import 'package:meetingme/screens/dashboard/user_dashboard_screen.dart';
import 'package:meetingme/screens/exam_board/exam_board_screen.dart';
import 'package:meetingme/screens/fees/fees_screeen.dart';
import 'package:meetingme/screens/fees/payment_history.dart';
import 'package:meetingme/screens/fees/payment_screen.dart';
import 'package:meetingme/screens/fees/payment_screen_sdk.dart';
import 'package:meetingme/screens/live_meeting/meeting_screen.dart';
import 'package:meetingme/screens/login/login_screen.dart';
import 'package:meetingme/screens/password_change/otp_verification.dart';
import 'package:meetingme/screens/room/all_subject_screen.dart';
import 'package:meetingme/screens/room/subject_sreen.dart';
import 'package:meetingme/screens/task_screens/assignment_screen.dart';
import 'package:meetingme/screens/splash/splash_screen.dart';
import 'package:meetingme/screens/workshop/details.dart';
import 'package:meetingme/screens/workshop/list.dart';
import 'package:meetingme/screens/workshop/wp_Details.dart';
import 'package:meetingme/services/general_data_service.dart';
import 'package:meetingme/services/login_service.dart';
import 'package:meetingme/services/tasks_data_service.dart';
import 'package:meetingme/models/workshop/workshop_list_model.dart'
    as workshopList;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            LoginInitState(),
            LoginService(),
            DataService(),
          ),
        ),
        BlocProvider(
          create: (context) => NotesBloc(
            NotesInitState(),
            TasksService(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'MeetingMe-Workshop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: WorkshopList(),
        // LoginScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == SplashScreen.routeName) {
            return MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            );
          }
          if (settings.name == LoginScreen.routeName) {
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
          }
          if (settings.name == WorkshopList.routeName) {
            return MaterialPageRoute(
              builder: (_) => WorkshopList(),
            );
          }
          if (settings.name == OtpVerification.routeName) {
            return MaterialPageRoute(
              builder: (_) => OtpVerification(),
            );
          }
          if (settings.name == PaymentWebView.routeName) {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => PaymentWebView(
                paymentUrl: args,
              ),
            );
          }
          if (settings.name == UserDashboard.routeName) {
            final args = settings.arguments as User;
            return MaterialPageRoute(
              builder: (context) {
                return UserDashboard(
                  userInfo: args,
                );
              },
            );
          }
          if (settings.name == Meeting.routeName) {
            final args = settings.arguments as MeetingArguments;
            return MaterialPageRoute(
              builder: (context) {
                return Meeting(
                  userName: args.userName,
                  lobbyName: args.lobbyName,
                  name: args.name,
                );
              },
            );
          }
          if (settings.name == Fees.routeName) {
            return MaterialPageRoute(
              builder: (_) {
                return Fees();
              },
            );
          }
          if (settings.name == PaymentHistory.routeName) {
            return MaterialPageRoute(
              builder: (_) {
                return PaymentHistory();
              },
            );
          }
          if (settings.name == SubjectScreen.routeName) {
            final args = settings.arguments as RoomArguments;
            return MaterialPageRoute(
              builder: (_) {
                return SubjectScreen(
                  id: args.id,
                  subject: args.subject,
                  description: args.description,
                  room: args.room,
                );
              },
            );
          }
          if (settings.name == ExamBoardScreen.routeName) {
            return MaterialPageRoute(
              builder: (_) {
                return ExamBoardScreen();
              },
            );
          }
          if (settings.name == AllSubjectScreen.routeName) {
            final args = settings.arguments as Future<RoomInfo>;
            return MaterialPageRoute(
              builder: (_) {
                return AllSubjectScreen(args);
              },
            );
          }
          if (settings.name == AssignmentScreen.routeName) {
            final args = settings.arguments as AssignmentArguments;
            return MaterialPageRoute(
              builder: (_) {
                return AssignmentScreen(
                  id: args.id,
                  files: args.files,
                  comments: args.comments,
                  createdAt: args.createdAt,
                  updatedAt: args.updatedAt,
                  isActive: args.isActive,
                  name: args.name,
                  description: args.description,
                  mark: args.mark,
                  submissionDateTime: args.submissionDateTime,
                  createdBy: args.createdBy,
                  updatedBy: args.updatedBy,
                  roomSubject: args.roomSubject,
                  hasSubmitted: args.hasSubmitted,
                );
              },
            );
          }
          if (settings.name == WorkshopDetails.routeName) {
            return MaterialPageRoute(
              builder: (_) {
                final args = settings.arguments as workshopList.Results;
                return WorkshopDetails(
                  singleWorkhopModel: args,
                );
              },
            );
          }
          if (settings.name == WPDetails.routeName) {
            return MaterialPageRoute(
              builder: (_) {
                final args = settings.arguments as String;
                return WPDetails(
                  wpUrl: args,
                );
              },
            );
          }
          return null;
        },
      ),
    );
  }
}
