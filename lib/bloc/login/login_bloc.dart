import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:meetingme/bloc/login/login_event.dart';
import 'package:meetingme/bloc/login/login_state.dart';
import 'package:meetingme/services/general_data_service.dart';

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

          if (token.access != 'error') {
            await SessionManager().destroy();
            var sessionManager = SessionManager();
            await sessionManager.set("token", token.access);

            var userInfo = await dataService.getUserInfo();
            await sessionManager.set("userType", userInfo.userType);

            emit(UserLoginSuccessState(userInfo));
          } else {
            emit(ErrorLoginState(message: 'LoginFailed'));
          }

          // if (userInfo.user_type == 'REGULAR') {
          //   emit(UserLoginSuccessState(userInfo));
          // } else if (userInfo.user_type == 'ORGANIZATION') {
          //   emit(UserLoginSuccessState(userInfo));
          // }
        } else {
          emit(ErrorLoginState(message: 'LoginFailed'));
        }
      },
    );
  }
}
