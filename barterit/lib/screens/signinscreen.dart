import 'package:barterit/mainscreen.dart';
// import 'package:barterit/screens/sellerscreen.dart';
// import 'package:barterit/splashscreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
// import '../mainscreens/landingscreen.dart';
import '../models/user.dart';
import '../phpconfig.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import '../userobject/user.dart';
import 'signupscreen.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_splash_screen/signinscreen.dart';
// import 'main.dart';
// import 'signinscreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isHidden = false;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isHidden = true;
    loadPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7FFF7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  width: double.infinity,
                  color: Colors.indigo,
                  height: 250,
                  child: const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 36,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _email,
                        validator: (value) => value!.isEmpty ||
                                !value.contains("@") ||
                                !value.contains(".")
                            ? "Enter a valid email"
                            : null,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: isHidden,
                        controller: _password,
                        validator: (value) =>
                            value!.isEmpty || (value.length < 8)
                                ? "Password must be at least 8 characters"
                                : null,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            icon: Icon(isHidden
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  isChecked = value!;
                                  print(isChecked);
                                  rememberMe(value);
                                  setState(() {});
                                },
                              ),
                              const Text('Remember me'),
                            ],
                          ),
                          const Text(
                            'Forgot password?',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      TextButton(
                        onPressed: () {
                          login();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Log in'),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                'or',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.indigo,
                          backgroundColor: const Color(0xffF7FFF7),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: const BorderSide(
                            color: Colors.indigo,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Check your input"),
        ),
      );
      return;
    }
    String email = _email.text;
    String password = _password.text;
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
        if (jsondata['status'] == 'success') {
          User user = User.fromJson(jsondata['data']);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (content) => MainScreen(user: user),
            ),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Login Failed")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Failed")));
      }
    }).timeout(
      const Duration(seconds: 3),
      onTimeout: () {},
    );
  }

  void rememberMe(bool isChecked) async {
    FocusScope.of(context).requestFocus(FocusNode());
    String email = _email.text;
    String password = _password.text;
    SharedPreferences preference = await SharedPreferences.getInstance();

    if (isChecked) {
      if (!_formKey.currentState!.validate()) {
        isChecked = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill data first"),
          ),
        );
        return;
      }
      await preference.setString('email', email);
      await preference.setString('password', password);
      await preference.setBool("rememberMe", true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preference Stored"),
        ),
      );
    } else {
      await preference.setString('email', '');
      await preference.setString('password', '');
      await preference.setBool('rememberMe', false);
      _email.text = '';
      _password.text = '';
      isChecked = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preference Removed"),
        ),
      );
    }
  }

  Future<void> loadPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = (preferences.getString('email')) ?? '';
    String password = (preferences.getString('password')) ?? '';
    isChecked = (preferences.getBool('rememberMe')) ?? false;
    if (isChecked) {
      _email.text = email;
      _password.text = password;
      setState(() {});
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    final path = Path();

    path.lineTo(0, height);
    path.quadraticBezierTo(width / 4, height - 40, width / 2, height - 20);
    path.quadraticBezierTo(3 / 4 * width, height, width, height - 30);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
