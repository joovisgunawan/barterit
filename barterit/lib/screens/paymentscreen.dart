import 'dart:core';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/cart.dart';

import '../models/user.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final List<Cart> cart;
  final double totalPrice;
  const PaymentScreen(
      {super.key,
      required this.user,
      required this.cart,
      required this.totalPrice});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WebViewController web = WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var cart = widget.cart;
    // List order = [];
    String baseUrl =
        'https://script.google.com/macros/s/AKfycbwILuwJz17fG7EGmKMRvtVsOQIRj4ztc0wyn-w33gBV/dev?id=${widget.user.id}&name=${widget.user.name}&email=${widget.user.email}&totalPrice=${widget.user.email}';
    // String parameter = baseUrl;
    // for (int i = 0; i < cart.length; i++) {
    //   Cart newcart = cart[i];
    //   if (i != cart.length - 1) {
    //     parameter +=
    //         "id${i + 1}=${widget.cart[i].buyerId}&name${i + 1}=${widget.cart[i].sellerId}&email${i + 1}=${widget.user.email}&price${i + 1}=${widget.user.name}&";
    //   } else {
    //     parameter +=
    //         "id${i + 1}=${widget.cart[i].buyerId}&name${i + 1}=${widget.cart[i].sellerId}&email${i + 1}=${widget.user.email}&price${i + 1}=${widget.user.name}";
    //   }
    // }
    // print(parameter);
    // for (int i = 0; i < cart.length; i++) {}
    web
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://script.google.com/macros/s/AKfycbwILuwJz17fG7EGmKMRvtVsOQIRj4ztc0wyn-w33gBV/dev?id=${widget.user.id}&name=${widget.user.name}&email=${widget.user.email}&total_price=${widget.totalPrice}'))
      // .then((value) {} );
      // ..addJavaScriptChannel(name, onMessageReceived: onMessageReceived)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            readResponse();
          },
        ),
      );
    // method: LoadRequestMethod.post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      // body: Column(
      //   children: [
      //     Text(widget.cart.length.toString()),
      //     Text(widget.cart[0].cartId.toString()),
      //     Text(widget.totalPrice.toString()),
      //   ],
      // ),
      body: Center(
        child: WebViewWidget(
          controller: web,
        ),
      ),
    );
  }

  void readResponse() {}
}
