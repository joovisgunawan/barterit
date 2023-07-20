import 'dart:async';
import 'dart:convert';
import 'package:barterit/mainscreen.dart';
import 'package:barterit/onboardscreen.dart';
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
        color: const Color.fromARGB(255, 163, 177, 255),
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: Image(
            image: AssetImage(
              'assets/images/logo.png',
            ),
            width: 250,
          ),
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
    print('response.body1');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    bool seenOnBoard = prefs.getBool('seenOnBoard') ?? false;
    bool rememberMe = (prefs.getBool('rememberMe') ?? false);
    User user;
    if (!seenOnBoard) {
      print('response.body2');
      Timer(
        const Duration(milliseconds: 3000),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (content) => const OnBoardScreen(),
          ),
        ),
      );
    } else {
      print('response.body3');
      if (rememberMe) {
        print('response.body4');
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
              Timer(
                const Duration(milliseconds: 3000),
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (content) => MainScreen(
                        user: user,
                        index: 0,
                      ),
                    ),
                  );
                },
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
              Timer(
                const Duration(milliseconds: 3000),
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (content) => MainScreen(
                        user: user,
                        index: 0,
                      ),
                    ),
                  );
                },
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
            Timer(
              const Duration(milliseconds: 3000),
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (content) => MainScreen(
                      user: user,
                      index: 0,
                    ),
                  ),
                );
              },
            );
          }
        }).timeout(const Duration(seconds: 5), onTimeout: () {
          user = User(
              id: "na",
              name: "na",
              email: "na",
              password: "na",
              gender: "na",
              phone: "na",
              address: "na");
          Timer(
            const Duration(milliseconds: 3000),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (content) => MainScreen(
                  user: user,
                  index: 0,
                ),
              ),
            ),
          );
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
        Timer(
          const Duration(milliseconds: 3000),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (content) => MainScreen(
                user: user,
                index: 0,
              ),
            ),
          ),
        );
      }
    }
    setState(() {});
  }
}
