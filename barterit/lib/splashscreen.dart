// import 'package:barterit/homescreen.dart';
import 'dart:convert';

import 'package:barterit/mainscreen.dart';
import 'package:barterit/onboardscreen.dart';
import 'package:barterit/screens/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';
import 'phpconfig.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _seenOnBoard;
  // bool? _login;
  @override
  void initState() {
    super.initState();
    checkFirstRun();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.network('https://picsum.photos/150/150'),
      nextScreen:
          _seenOnBoard == true ? const SignInScreen() : const OnBoardScreen(),
      duration: 3000,
    );
  }

  checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seenOnBoard = prefs.getBool('seenOnBoard') ?? false;

    if (seenOnBoard) {
      _seenOnBoard = true;
    } else {
      _seenOnBoard = false;
    }
    // setState(() {});
    // print(_seenOnBoard);
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    bool rememberMe = (prefs.getBool('rememberMe') ?? false);
    late User user;
    if (rememberMe) {
      http.post(
        Uri.parse("${PhpConfig().SERVER}/barterit/php/signin.php"),
        body: {
          "email": email,
          "password": password,
        },
      ).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          var jsondata = jsonDecode(response.body); //decode==parse
          user = User.fromJson(jsondata['data']);
          if (jsondata['status'] == 'success') {
            // _login = true;
            _seenOnBoard = true;
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (content) => MainScreen(
            //       user: user,
            //     ),
            //   ),
            // );
          } else {
            // _login = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Login Failed"),
              ),
            );
          }
        } else {
          // _login = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Failed"),
            ),
          );
        }
      }).timeout(
        const Duration(seconds: 3),
        onTimeout: () {},
      );
    }
    // print(_seenOnBoard);
    // print(_login);
    setState(() {}); //important
  }
}
