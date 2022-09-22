import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waste_application/drop/droppointui.dart';
import 'package:waste_application/pages/edit_profile.dart';
import 'package:waste_application/pages/history_page.dart';
import 'package:waste_application/pages/home/main_page.dart';
import 'package:waste_application/pages/profile_page.dart';
import 'package:waste_application/pages/qrcode_page.dart';
import 'package:waste_application/pages/reward_testing.dart';
import 'package:waste_application/pages/sheet_education.dart';
import 'package:waste_application/pages/sign_in_page.dart';
import 'package:waste_application/pages/sign_up_page.dart';
import 'package:waste_application/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:waste_application/view_model/reward_option_view_model.dart';
// import 'package:waste_application/drop/droppointui.dart';
import 'theme.dart';
import 'pages/otp/otp_verification.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => SignUpPage(),
        '/home': (context) => MainPage(),
        '/education': (context) => EducationPage(),
        '/qrcode': (context) => QrCodePage(),
        '/order-history': (context) => OrderHistory(),
        '/profile': (context) => ProfilePage(),
        '/otp-verif': (context) => OTPVerification(
              username: 'default',
              no_telphone: 'default',
            ),
        '/edit-profile': (context) => EditProfilePage(
              email: "testing@gmail.com",
            ),
        // '/reward': (context) => ChangeNotifierProvider(
        //       create: (context) => RewardOptionListViewModel(),
        //       child: const RewardPage(),
        //     ),
        '/droppoint': (context) => DropPointPage(),
      },
    );
  }
}
