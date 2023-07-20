import 'dart:convert';

import 'package:barterit/screens/paymentscreen.dart';
import 'package:flutter/material.dart';

import '../mainscreen.dart';
import '../models/cart.dart';
import '../models/product.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

import '../phpconfig.dart';

class BargainScreen extends StatefulWidget {
  final User user;
  final Product sellerProduct;
  final Product buyerProduct;
  const BargainScreen(
      {super.key,
      required this.user,
      required this.sellerProduct,
      required this.buyerProduct});

  @override
  State<BargainScreen> createState() => _BargainScreenState();
}

class _BargainScreenState extends State<BargainScreen> {
  List productList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bargain'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              "${PhpConfig().SERVER}/barterit/catches/${widget.sellerProduct.productId}.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.sellerProduct.productName.toString()),
                              Text(widget.sellerProduct.productLocality
                                  .toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Exachange with'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              "${PhpConfig().SERVER}/barterit/catches/${widget.buyerProduct.productId}.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.buyerProduct.productName.toString()),
                              Text(widget.buyerProduct.productLocality
                                  .toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (content) => MainScreen(
                              user: widget.user,
                              index: 0,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.indigo,
                        backgroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: Colors.indigo,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                    child: TextButton(
                      onPressed: () {
                        barter();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: Colors.indigo,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Text(
                        'Barter Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void barter() {
    http.post(
      Uri.parse("${PhpConfig().SERVER}/barterit/php/addbarter.php"),
      body: {
        'buyer_id': widget.user.id,
        'seller_id': widget.sellerProduct.sellerId,
        'seller_product_id': widget.sellerProduct.productId,
        'buyer_product_id': widget.buyerProduct.sellerId,
      },
    ).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Barter Sent")));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (content) => MainScreen(
                user: widget.user,
                index: 0,
              ),
            ),
          );
        }
        setState(() {});
      }
    });
  }

  void getProduct(int currentPage) {
    if (widget.user.id == "na") {
      setState(() {
        // titlecenter = "Unregistered User";
      });
      return;
    }
    http.post(
      Uri.parse("${PhpConfig().SERVER}/barterit/php/getproduct.php"),
      body: {
        'user_id': widget.user.id,
      },
    ).then((response) {
      print(response.body);
      productList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          var extractData = jsondata['data'];
          extractData['product'].forEach((product) {
            productList.add(Product.fromJson(product));
          });
          print(widget.user.id);
        }
        setState(() {});
      }
    });
  }
}
