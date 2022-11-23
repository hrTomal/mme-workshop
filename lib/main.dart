import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetingme/bloc/login/login_bloc.dart';
import 'package:meetingme/bloc/login/login_state.dart';
import 'package:meetingme/screens/dashboard/user_dashboard_screen.dart';
import 'package:meetingme/screens/live_meeting/jitsi_meet.dart';
import 'package:meetingme/screens/login/login_screen.dart';
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
          if (settings.name == LoginScreen.routeName) {
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
          }
          if (settings.name == UserDashboard.routeName) {
            return MaterialPageRoute(
              builder: (_) => UserDashboard(),
            );
          }
          if (settings.name == Meeting.routeName) {
            return MaterialPageRoute(
              builder: (_) => Meeting(),
            );
          }
          return null;
        },
      ),
    );
  }
}
