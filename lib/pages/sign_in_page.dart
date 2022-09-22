import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_application/pages/otp/otp_verification.dart';
import 'package:waste_application/services_and_dataclass/username_login.dart';
import 'package:waste_application/theme.dart';
import 'package:waste_application/utils/auth_message.dart';
import 'package:waste_application/services_and_dataclass/sv_user_sgup.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Sign In to Continue ',
              style: subtitleTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      );
    }

    Widget _emailForm() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: text_barStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: bgColor8,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: text_bar,
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      spreadRadius: 0),
                ],
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/email_icon.png',
                      width: 23,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Your Email Address',
                          hintStyle: subtitleTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    }

    Widget _password() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: text_barStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: bgColor8,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: text_bar,
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      spreadRadius: 0),
                ],
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/password_icon.png',
                      width: 23,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        //controller: _emailController,
                        controller: passwordController,
                        obscureText: _secureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: _secureText
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 23,
                                  ) // icon
                                : Icon(
                                    Icons.visibility,
                                    size: 23,
                                  ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Your Password',
                          hintStyle: subtitleTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                        ),
                        style: text_barStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    }

    //sign in firebase
    signIn(String telfon) {
      try {
         FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        // Navigator.pushNamed(context, '/home',
        //     arguments: LoginInfo(emailController.text.toString()));
        if (telfon != ""){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  OTPVerification(username: emailController.text.trim(), no_telphone: telfon)),
        );
        }
       
      } on FirebaseAuthException catch (e) {
        AuthMessage.showSnackBar(e.message);
      }
    }

    Widget _button() {
      return Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          //onPressed: signInFunc,
          onPressed: () {
           var telfon = DataUser.getUserPhone(emailController.text.toString());
            signIn(telfon);
            //Navigator.pushNamed(context, '/home');
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Sign In',
            style: button_TextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    Widget _footer() {
      return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dont\'t have an account? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Text(
                'Sign Up',
                style: primaryTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            )
          ],
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: AuthMessage.messengerKey,
      home: Scaffold(
        backgroundColor: bgColor8,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                _emailForm(),
                _password(),
                _button(),
                Spacer(),
                _footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
