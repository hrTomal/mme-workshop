import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetingme/bloc/login/login_event.dart';
import 'package:meetingme/bloc/login/login_state.dart';
import 'package:meetingme/services/general_data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/login_service.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginService loginService;
  DataService dataService;
  LoginBloc(LoginStates initialState, this.loginService, this.dataService)
      : super(initialState) {
    on<LoginEvents>(
      (event, emit) async {
        if (event is InitialEvent) {
          emit(LoginInitState());
        } else if (event is LoginButtonPressed) {
          emit(LoginLoadingState());
          var token = await loginService.Login(
              event.phone, event.password, event.country_code);
          var userInfo = await dataService.getUserInfo(token);
          //emit(UserLoginSuccessState());
          if (userInfo.user_type == 'REGULAR') {
            emit(UserLoginSuccessState());
          } else if (userInfo.user_type == 'ORGANIZATION') {
            emit(OrganizationLoginSuccessState());
          }
        } else {
          emit(ErrorLoginState(message: 'LoginFailed'));
        }
      },
    );
  }

  // Stream<LoginStates> mapEventToStates(LoginEvents event) async* {
  //   var pref = await SharedPreferences.getInstance();
  //   if (event is InitialEvent) {
  //     yield LoginInitState();
  //   } else if (event is LoginButtonPressed) {
  //     yield LoginLoadingState();
  //     var token = await loginService.Login(
  //         event.phone, event.password, event.country_code);
  //     var userInfo = await dataService.getUserInfo(token);

  //     if (userInfo['user_type'] == 'REGULAR') {
  //       yield UserLoginSuccessState();
  //     } else if (userInfo['user_type'] == 'ORGANIZATION') {
  //       yield OrganizationLoginSuccessState();
  //     }
  //   } else {
  //     yield ErrorLoginState(message: "Login Failed");
  //   }
  // }
}
