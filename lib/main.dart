import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetingme/bloc/login/login_bloc.dart';
import 'package:meetingme/bloc/login/login_state.dart';
import 'package:meetingme/models/room_info.dart';
import 'package:meetingme/models/user.dart';
import 'package:meetingme/screens/dashboard/user_dashboard_screen.dart';
import 'package:meetingme/screens/fees/fees_screeen.dart';
import 'package:meetingme/screens/fees/payment_history.dart';
import 'package:meetingme/screens/fees/payment_screen.dart';
import 'package:meetingme/screens/live_meeting/meeting_screen.dart';
import 'package:meetingme/screens/login/login_screen.dart';
import 'package:meetingme/screens/room/subject_sreen.dart';
import 'package:meetingme/screens/splash/splash_screen.dart';
import 'package:meetingme/services/general_data_service.dart';
import 'package:meetingme/services/login_service.dart';

void main() {
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
        )
      ],
      child: MaterialApp(
        title: 'MeetingMe',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const SplashScreen(),
        // routes: {
        //   LoginScreen.routeName: (context) => LoginScreen(),
        // },
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
          return null;
        },
      ),
    );
  }
}
