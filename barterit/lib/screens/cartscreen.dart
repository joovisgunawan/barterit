import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

import '../phpconfig.dart';

class CartScreen extends StatefulWidget {
  final User user;
  const CartScreen({super.key, required this.user});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List cartList = [];
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  double totalprice = 0.0;
  @override
  void initState() {
    super.initState();
    loadcart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('cart'),
        ),
        body: cartList.isEmpty
            ? Center(
                child: Text('empty'),
              )
            : Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Image.network(
                              "${PhpConfig().SERVER}/barterit/catches/${cartList[index].productId}.png",
                              // "https://picsum.photos/190/170",
                              width: 100,
                            ),
                            Column(
                              children: [
                                Text("${cartList[index].productName}"),
                                Text("${cartList[index].productCategory}"),
                                Text("${cartList[index].productPrice}"),
                              ],
                            ),
                            // Text("${widget.userProduct.productId}"),
                            // Text("${widget.userProduct.productName}"),
                            // Text("${widget.userProduct.productCategory}"),
                            // Text("${widget.userProduct.productDescription}"),
                            // Text("${widget.userProduct.productPrice}"),
                            // Text("${widget.userProduct.productQuantity}"),
                            // Text("${widget.userProduct.productState}"),
                            // Text("${widget.userProduct.productLocality}"),
                          ],
                        ),
                      );
                    },
                  ))
                ],
              ));
  }

  void loadcart() {
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/getcart.php"),
        body: {
          "userid": widget.user.id,
        }).then((response) {
      print(response.body);
      cartList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          print('succes retrive cart2');
          var extractData = jsondata['data'];
          extractData['cart'].forEach((cart) {
            cartList.add(Cart.fromJson(cart));
          });
          print(cartList.length);
          cartList.forEach((element) {
            totalprice =
                totalprice + double.parse(element.productPrice.toString());
          });
          print(totalprice);
        }
        setState(() {});
      }
    });
  }
}
