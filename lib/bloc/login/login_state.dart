import 'package:equatable/equatable.dart';

import '../../models/user.dart';

class LoginStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class UserLoginSuccessState extends LoginStates {
  final User userInfo;

  UserLoginSuccessState(this.userInfo);
}

class OrganizationLoginSuccessState extends LoginStates {}

class AdminLoginSuccessState extends LoginStates {}

class ErrorLoginState extends LoginStates {
  final String message;

  ErrorLoginState({required this.message});
}
