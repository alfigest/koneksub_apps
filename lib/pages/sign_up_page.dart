// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waste_application/services_and_dataclass/dc_user_sgup.dart';
import 'package:waste_application/services_and_dataclass/sv_user_sgup.dart';
import 'package:waste_application/services_and_dataclass/username_login.dart';
import 'package:waste_application/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:waste_application/utils/auth_message.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // final formKey = GlobalKey<
  //     FormState>(); //untuk validate email, text   email_validator: ^2.1.17
  // final formKey2 = GlobalKey<FormState>();
  // final formKeyUsername = GlobalKey<FormState>();

  //revisi duplicate globalkey https://stackoverflow.com/questions/49371221/duplicate-globalkey-detected-in-widget-tree
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  //GlobalObjectKey<FormState> formKeyUsername = GlobalObjectKey<FormState>();
  GlobalKey<FormState> formKeyUsername = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  String getEmailUsername(String email_name) {
    //untuk ngambil username dari email
    int i = 0;
    while (i < email_name.length) {
      if (email_name[i] == "@") {
        return email_name.substring(0, i);
      }
      i++;
    }
    return "get_username_from_email";
  }

  @override
  Widget build(BuildContext context) {
    //form key agar tidak duplicate dijadikan satu
    Widget gabunganForm() {
      return Container(
        child: Form(
          key: formKeyUsername,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //username start
              // Text(
              //   'User Name',
              //   style: text_barStyle.copyWith(
              //     fontSize: 16,
              //     fontWeight: medium,
              //   ),
              // ),
              // SizedBox(height: 12),
              // Container(
              //   height: 50,
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   decoration: BoxDecoration(
              //     color: bgColor8,
              //     borderRadius: BorderRadius.circular(12),
              //     boxShadow: [
              //       BoxShadow(
              //           color: text_bar,
              //           offset: Offset(0, 1),
              //           blurRadius: 4,
              //           spreadRadius: 0),
              //     ],
              //   ),
              //   child: Center(
              //     child: Row(
              //       children: [
              //         // Image.asset(
              //         //   'assets/email_icon.png',
              //         //   width: 23,
              //         // ),
              //         Icon(
              //           Icons.person,
              //           color: Colors.grey,
              //         ),
              //         SizedBox(width: 16),
              //         Expanded(
              //           child: TextFormField(
              //             // controller: emailController,
              //             keyboardType: TextInputType.text,
              //             decoration: InputDecoration.collapsed(
              //               hintText: 'Your Username',
              //               hintStyle: subtitleTextStyle,
              //             ),
              //             autovalidateMode: AutovalidateMode.onUserInteraction,
              //             validator: (value) =>
              //                 value != null && value.length < 6
              //                     ? 'Minimum user 6 character'
              //                     : null,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),
              //username end

              //emailaddress start
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
                            hintStyle: subtitleTextStyle,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              //emailaddress end

              //phone number start
              Text(
                'Phone Number',
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
                      // Image.asset(
                      //   'assets/email_icon.png',
                      //   width: 23,
                      // ),
                      Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: telephoneController,
                          //.collapsed
                          decoration: InputDecoration.collapsed(
                            hintText: 'Your Phone Number, ex : 857xxx',
                            hintStyle: subtitleTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              //phone number end

              //[password start]
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter minimum 6 char'
                                  : null,
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
              //[password end]
            ],
          ),
        ),
      );
    }

    Widget _header() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign Up',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Register ',
              style: subtitleTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      );
    }

    //buat allert dialog
    AlertMsg(BuildContext context, String title, String message) {
      showAlertDialog() {
        Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {},
        );

        AlertDialog alert = AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            okButton,
          ],
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }

    //sign up firebase
    Future signUpFirebase() async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(),
              ));

      final isValid = formKeyUsername.currentState!.validate();
      // final isValid2 = formKey2.currentState!.validate();

      if (!isValid) return;
      try {
        //create data in auth
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString());
        //input data to firestore
        final dataSignUp = userSignUp(
            username: getEmailUsername(emailController.text.toString()),
            email: emailController.text.toString(),
            phone_number: telephoneController.text.toString());
        DataUser.addUsersData(
            data: dataSignUp, docID: emailController.text.toString());
        //pindah page
        Navigator.pushNamed(context, '/home',
            arguments: LoginInfo(emailController.text.toString()));
      } on FirebaseAuthException catch (e) {
        AlertMsg(context, "Tidak bisa", e.message.toString());
        AuthMessage.showSnackBar(e.message);
      }
    }

    Widget _button() {
      return Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          // onPressed: signUpFirebase,
          onPressed: () {
            signUpFirebase();
            //Navigator.pushNamed(context, '/home');
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Sign Up',
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
              'Already have an account? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-in');
              },
              child: Text(
                'Sign In',
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
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                gabunganForm(),
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
