import 'package:flutter/material.dart';

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
              height: 50,
            ),
            DropdownButton(
              hint: Text('Country'), // Not necessary for Option 1
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
                navigateToNext(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  navigateToNext(BuildContext context) {}
}
