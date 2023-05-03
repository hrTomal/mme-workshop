import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meetingme/bloc/login/login_bloc.dart';
import 'package:meetingme/bloc/login/login_event.dart';
import 'package:meetingme/bloc/login/login_state.dart';
import 'package:meetingme/constants/colors.dart';
import 'package:meetingme/models/country.dart';
import 'package:meetingme/screens/dashboard/user_dashboard_screen.dart';
import 'package:meetingme/screens/password_change/otp_verification.dart';
import 'package:meetingme/screens/workshop/list.dart';
import 'package:meetingme/services/login_service.dart';

import '../../components/components.dart';
import '../../widgets/constant_widgets.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

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
  Future<bool> onWillPop() async {
    Navigator.pushNamed(context, WorkshopList.routeName);
    return true;
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
          return Center(
            child: LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF1A1A3F),
              rightDotColor: const Color(0xFFEA3799),
              size: 200,
            ),
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
                title: const Text('Error'),
                content: Text(state.message),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Close me!'),
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
              return Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: ConstantColors.primaryColor,
                  size: 100,
                ),
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
                maxLength: 11,
                decoration: roundedInputFieldDecoration.copyWith(
                  hintText: "Phone No",
                  icon: const Icon(Icons.phone),
                  counterText: '',
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
              backgroundColor: ConstantColors.loginButtonColor,
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
              var country = _selectedCountry ?? 'null';
              if (country == 'null') {
                Fluttertoast.showToast(
                    msg: "Please Select Country First.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (phone.text == '') {
                Fluttertoast.showToast(
                    msg: "Please Enter Phone Number.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (password.text == '') {
                Fluttertoast.showToast(
                    msg: "Please Enter Your Password.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                loginBloc.add(
                  LoginButtonPressed(
                    phone: phone.text, //'01954492600'
                    password: password.text, //'1234'
                    country_code:
                        _selectedCountry!, //'BD', //'BD' _selectedCountry!
                  ),
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, OtpVerification.routeName);
            },
            child: const Text(
              'Forgot Password',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, WorkshopList.routeName);
            },
            child: const Text('Show All Workshops'),
          ),
        ],
      ),
    );
  }

  navigateToNext(BuildContext context) {
    var _countries = LoginService().getCountries();
  }
}
