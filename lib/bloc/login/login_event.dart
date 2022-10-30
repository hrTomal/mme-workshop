import 'package:equatable/equatable.dart';

class LoginEvents extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialEvent extends LoginEvents {}

class LoginButtonPressed extends LoginEvents {
  final String phone;
  final String password;
  final String country_code;

  LoginButtonPressed({
    required this.phone,
    required this.password,
    required this.country_code,
  });
}
