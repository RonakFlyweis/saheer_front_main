import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simpleprogressdialog/builders/material_dialog_builder.dart';
import 'package:simpleprogressdialog/simpleprogressdialog.dart';
import 'package:urban_home/api_provider/url.dart';
import '../../constant/constant.dart';
import '../screens.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog =
        ProgressDialog(context: (context), barrierDismissible: false);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: blackColor,
                ),
              )
            ],
          ),
          SizedBox(height: 70.0),
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
                'Register your account',
                style: grey14BoldTextStyle,
              ),
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
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
                  child: TextField(
                    controller: username,
                    style: black14MediumTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: 'Username',
                      hintStyle: black14MediumTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
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
                  child: TextField(
                    controller: email,
                    style: black14MediumTextStyle,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: 'Email',
                      hintStyle: black14MediumTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              height20Space,
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Container(
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
                  child: TextField(
                    controller: address,
                    style: black14MediumTextStyle,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20.0),
                      hintText: 'Address',
                      hintStyle: black14MediumTextStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              height20Space,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                child: InkWell(
                  onTap: () async {
                    var data = {
                      'email': email.text.toString(),
                      'name': username.text.toString(),
                      'address': address.text.toString()
                    };
                    ApiProvider api = ApiProvider();
                    progressDialog.showMaterial(
                        layout: MaterialProgressDialogLayout
                            .overlayCircularProgressIndicator);
                    int code = await api.getMethodAuthorized('api/userdetail');
                    progressDialog.dismiss();
                    if (code == 200) {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: OTPScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Registration failed")));
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
              height20Space,
            ],
          ),
        ],
      ),
    );
  }
}
