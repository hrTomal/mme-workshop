import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meetingme/bloc/login/login_bloc.dart';
import 'package:meetingme/bloc/login/login_event.dart';
import 'package:meetingme/bloc/login/login_state.dart';
import 'package:meetingme/models/country.dart';
import 'package:meetingme/screens/dashboard/user_dashboard_screen.dart';
import 'package:meetingme/screens/splash/splash_screen.dart';
import 'package:meetingme/services/login_service.dart';
import 'package:meetingme/services/room_data_service.dart';

import '../../components/components.dart';
import '../../widgets/constant_widgets.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _selectedCountry;
  //late var _countries;
  var phone = TextEditingController();
  var password = TextEditingController();
  late LoginBloc loginBloc;

  final _countries = LoginService().getCountries();

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    setState(() {});
    super.initState();
  }

  // Dialog error
  _showDialog(context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Text('Username or password wrong'),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final msg = BlocBuilder(
      builder: (context, state) {
        if (state is ErrorLoginState) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(state.message),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );

          // Text(state.message);
        } else if (state is LoginLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );

    return Scaffold(
      body: BlocListener<LoginBloc, LoginStates>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            Navigator.pushNamed(context, UserDashboard.routeName,
                arguments: state.userInfo);
          }
        },
        child: BlocBuilder<LoginBloc, LoginStates>(
          builder: (context, state) {
            if (state is ErrorLoginState) {
              //return LoginInitState();
              return AlertDialog(
                title: Text('Error'),
                content: Text(state.message),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('Close me!'),
                    onPressed: () {
                      loginBloc.add(
                        InitialEvent(),
                      );
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                  )
                ],
              );
            } else if (state is LoginLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return LoginWidget(deviceHeight, deviceWidth);
            }
          },
        ),
      ),
    );
  }

  SafeArea LoginWidget(double deviceHeight, double deviceWidth) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: deviceHeight * .08,
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Image.asset('assets/images/meetingme_logo.jpg'),
          ),
          const SizedBox(
            height: 40,
          ),
          FutureBuilder(
              future: _countries,
              builder:
                  (BuildContext context, AsyncSnapshot<CountryInfo> snapshot) {
                if (snapshot.hasData) {
                  /// When the result of the future call respond and has data show that data
                  var _countriesForDropDown = snapshot.data!.results;
                  //print(dat.data!.results);
                  return DropdownButton(
                    hint: const Text('Country'),
                    value: _selectedCountry,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCountry = newValue;
                      });
                    },
                    items: _countriesForDropDown
                        .map<DropdownMenuItem<String>>((Country value) {
                      return DropdownMenuItem<String>(
                        value: value.country_code,
                        child: Text('${value.name!}(${value.phone_code!})'),
                      );
                    }).toList(),
                  );
                }

                /// While is no data show this
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * .125),
            child: TextFieldContainer(
              child: TextField(
                textAlign: TextAlign.center,
                controller: phone,
                keyboardType: TextInputType.number,
                decoration: roundedInputFieldDecoration.copyWith(
                  hintText: "Phone No",
                  icon: const Icon(Icons.phone),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * .125),
            child: TextFieldContainer(
              child: TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                controller: password,
                decoration: roundedInputFieldDecoration.copyWith(
                  hintText: "Password",
                  icon: const Icon(Icons.lock_clock_outlined),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              loginBloc.add(
                LoginButtonPressed(
                  phone: phone.text, //'01954492600'
                  password: password.text, //'1234'
                  country_code: 'BD', //'BD' _selectedCountry!
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  navigateToNext(BuildContext context) {
    var _countries = LoginService().getCountries();
  }
}
