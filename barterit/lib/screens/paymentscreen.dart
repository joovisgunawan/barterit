import 'dart:core';

import 'package:barterit/screens/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/user.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  const PaymentScreen({super.key, required this.user});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController web = WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    web
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
// ..addJavaScriptChannel(name, onMessageReceived: onMessageReceived)

      ..loadRequest(Uri.parse(
          "https://script.google.com/macros/s/AKfycbwILuwJz17fG7EGmKMRvtVsOQIRj4ztc0wyn-w33gBV/dev?param1=${widget.user.name}&param2=${widget.user.id}"))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (content) => const SignInScreen(),
            ),
          );
        },
      ));
    // method: LoadRequestMethod.post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Center(
        child: WebViewWidget(
          controller: web,
        ),
      ),
    );
  }
}
