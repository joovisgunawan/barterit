import 'dart:convert';
import 'package:barterit/mainscreen.dart';
import 'package:flutter/material.dart';
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
    // checkFirstRun();
    checkLogin();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedSplashScreen(
  //     splash: Image.network('https://picsum.photos/150/150'),
  //     nextScreen:
  //         _seenOnBoard == true ? const SignInScreen() : const OnBoardScreen(),
  //     duration: 5000,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: Text('data'),
        ),
      ),
    );
  }

  // checkFirstRun() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool seenOnBoard = prefs.getBool('seenOnBoard') ?? false;
  //   if (seenOnBoard) {
  //     _seenOnBoard = true;
  //   } else {
  //     _seenOnBoard = false;
  //   }
  // }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    bool rememberMe = (prefs.getBool('rememberMe') ?? false);
    User user;
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
          //means succes call to login API
          var jsondata = jsonDecode(response.body); //decode==parse
          user = User.fromJson(jsondata['data']);
          if (jsondata['status'] == 'success') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (content) => MainScreen(
                  user: user,
                ),
              ),
            );
          } else {
            user = User(
                id: "na",
                name: "na",
                email: "na",
                password: "na",
                gender: "na",
                phone: "na",
                address: "na");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (content) => MainScreen(user: user),
              ),
            );
          }
        } else {
          user = User(
              id: "na",
              name: "na",
              email: "na",
              password: "na",
              gender: "na",
              phone: "na",
              address: "na");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (content) => MainScreen(user: user),
            ),
          );
        }
      });
    } else {
      user = User(
          id: "na",
          name: "na",
          email: "na",
          password: "na",
          gender: "na",
          phone: "na",
          address: "na");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (content) => MainScreen(user: user),
        ),
      );
    }
    setState(() {});
  }
}
