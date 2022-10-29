import 'package:equatable/equatable.dart';

class LoginStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class UserLoginSuccessState extends LoginStates {}

class OrganizationLoginSuccessState extends LoginStates {}

class ErrorLoginState extends LoginStates {
  final String message;

  ErrorLoginState(this.message);
}
