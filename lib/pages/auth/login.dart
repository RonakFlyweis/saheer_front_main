import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:urban_home/api_provider/url.dart';

import '../../constant/constant.dart';
import '../screens.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime currentBackPressTime;
  String phoneNumber = '';
  String phoneIsoCode = '+91';
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN', dialCode: '+91');

  // void onPhoneNumberChange(
  //     String number, String internationalizedPhoneNumber, String isoCode) {
  //   setState(() {ber = number;
  //     phoneIsoCode = isoCode;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(context: (context), barrierDismissible: false);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: WillPopScope(
        child: ListView(
          children: [
            SizedBox(height: 100.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon.png',
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30.0),
                Text(
                  'Signin with phone number',
                  style: grey14BoldTextStyle,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.only(left: fixPadding * 2.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: blackColor.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (value) {},
                      textStyle: black14RegularTextStyle,
                      //autoValidate: false,
                      selectorTextStyle: black16MediumTextStyle,
                      initialValue: number,
                      textFieldController: controller,
                      inputBorder: InputBorder.none,
                      inputDecoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(left: 0.0),
                        hintText: 'Phone Number',
                        hintStyle: black14RegularTextStyle,
                        border: InputBorder.none,
                      ),
                      //selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                  ),
                ),
                heightSpace,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () async {
                      progressDialog.showMaterial(layout: MaterialProgressDialogLayout.overlayCircularProgressIndicator);
                      print('+91' + controller.text.toString());
                      String number = controller.text.toString();
                      ApiProvider api = ApiProvider();
                      dynamic data = await api.onRequest(number);
                      print(data);
                      progressDialog.dismiss();
                      if (data == 201) {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: OTPScreen(
                              number: '+91' + controller.text.toString(),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Enter correct mobile number")));
                      }
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primaryColor,
                      ),
                      child: Text(
                        'Continue',
                        style: white14BoldTextStyle,
                      ),
                    ),
                  ),
                ),
                heightSpace,
                Text(
                  'We’ll send otp for verification',
                  style: black14MediumTextStyle,
                ),
                height20Space,
                height20Space,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF3B5998),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/facebook.png',
                          width: 37.0,
                          height: 37.0,
                          fit: BoxFit.cover,
                        ),
                        width20Space,
                        Text(
                          'Log in with Facebook',
                          style: white14MediumTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                height20Space,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: whiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          width: 37.0,
                          height: 37.0,
                          fit: BoxFit.cover,
                        ),
                        width20Space,
                        Text(
                          'Log in with Google',
                          style: black14MediumTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                height20Space,
              ],
            ),
          ],
        ),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
