import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meetingme/models/country.dart';
import 'package:meetingme/services/login_service.dart';

import '../../components/components.dart';
import '../../widgets/constant_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
    String? _selectedLocation;
    late var _countries;

    void loadCountries() async {
      var data = await LoginService().getCountries();
      setState(() {
        _countries = data.results;
      });
    }

    var phone = TextEditingController();
    var password = TextEditingController();

    @override
    void initState() {
      super.initState();
      Future.delayed(Duration.zero, () {
        setState(() {
          loadCountries();
        });
      });
    }

    return Scaffold(
      body: SafeArea(
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
            DropdownButton(
              hint: const Text('Country'), // Not necessary for Option 1
              value: _selectedLocation,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * .125),
              child: TextFieldContainer(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: phone,
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
                login();
                //loadCountries();
                //navigateToNext(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    var test = await LoginService().Login("01954492600", "1234", "BD");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(test.access);
  }

  navigateToNext(BuildContext context) {
    var _countries = LoginService().getCountries();
  }
}
