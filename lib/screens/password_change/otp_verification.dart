import 'package:flutter/material.dart';
import 'package:meetingme/screens/login/login_screen.dart';
import 'package:meetingme/services/common/show_toast.dart';
import 'package:meetingme/widgets/constant_widgets.dart';

import '../../components/components.dart';
import '../../services/general_data_service.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  static const routeName = '/otp_verfication';

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  var phone = TextEditingController();
  var otp = TextEditingController();
  var newPassword = TextEditingController();
  bool isOtpSent = false;
  bool isPhoneFieldDisabled = true;
  bool isOtpFieldDisabled = true;
  bool showNewPasswordField = false;
  var changeToken = "";
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * .125),
          child: TextFieldContainer(
            child: TextField(
              textAlign: TextAlign.center,
              controller: phone,
              enabled: isPhoneFieldDisabled,
              keyboardType: TextInputType.number,
              maxLength: 11,
              decoration: roundedInputFieldDecoration.copyWith(
                hintText: "Phone No",
                icon: const Icon(Icons.phone),
                // counterText: '',
              ),
            ),
          ),
        ),
        isOtpSent == true
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * .125),
                child: TextFieldContainer(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: otp,
                    enabled: isOtpFieldDisabled,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: roundedInputFieldDecoration.copyWith(
                      hintText: "OTP",
                      icon: const Icon(Icons.lock),
                      counterText: '',
                    ),
                  ),
                ),
              )
            : Container(),
        Visibility(
          visible: isOtpSent == false && showNewPasswordField == false,
          child: ElevatedButton(
            onPressed: () {
              sendOtp();
            },
            child: const Text('Send OTP'),
          ),
        ),
        Visibility(
          visible: isOtpSent == true && showNewPasswordField == false,
          child: ElevatedButton(
            onPressed: () {
              verificationMethod();
            },
            child: const Text('Verfiy'),
          ),
        ),
        Visibility(
          visible: showNewPasswordField == true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * .125),
                child: TextFieldContainer(
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: newPassword,
                    decoration: roundedInputFieldDecoration.copyWith(
                      hintText: "New Password",
                      icon: const Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  changePasswordMethod(context);
                },
                child: const Text('Change Password'),
              )
            ],
          ),
        ),
      ]),
    );
  }

  void verificationMethod() {
    DataService().verifyOtp(phone.text, otp.text).then(
      (value) {
        if (value.message == 'OTP not found') {
          ShowToast.ShowErrorToast('Otp did not match or used previously.');
        } else {
          setState(() {
            // verify Otp success
            isOtpFieldDisabled = false;
            showNewPasswordField = true;
            changeToken = value.token!;
          });
          ShowToast.ShowSuccessToast('Please set new Password now.');
        }
      },
    );
  }

  void changePasswordMethod(BuildContext context) {
    DataService().changePassword(newPassword.text, changeToken).then((value) {
      if (value.message == 'Password reset successful') {
        ShowToast.ShowSuccessToast('Password reset successful');
        Navigator.pushNamed(context, LoginScreen.routeName);
      } else {
        ShowToast.ShowErrorToast('Error... Something went wrong.');
      }
    });
  }

  void sendOtp() {
    DataService().sendOtp(phone.text).then(
      (value) {
        // print(value.message);
        if (value.message == 'OTP sent successfully') {
          setState(() {
            isOtpSent = true;
            isPhoneFieldDisabled = false;
          });
          ShowToast.ShowSuccessToast('OTP sent successfully');
        } else {
          ShowToast.ShowErrorToast(value.message);
        }
      },
    );
  }
}
