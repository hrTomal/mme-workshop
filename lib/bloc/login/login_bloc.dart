import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetingme/bloc/login/login_event.dart';
import 'package:meetingme/bloc/login/login_state.dart';

import '../../services/login_service.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc(LoginStates initialState) : super(initialState) {
    // TODO: implement LoginBloc
    throw UnimplementedError();
  }
}
