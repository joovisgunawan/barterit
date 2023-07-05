import 'dart:convert';

import 'package:barterit/screens/postproductscreen.dart';
// import 'package:barterit/screens/signinscreen.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

import '../phpconfig.dart';
// import 'signinscreen.dart';

class SellerScreen extends StatefulWidget {
  final User user;

  const SellerScreen({super.key, required this.user});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  List productList = [];
  String title = 'Seller';
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: productList.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 400,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            //asyn measn there is await there
                            // Product userProduct = Product.fromJson(
                            //   productList[index].toJson(),
                            // ); //select the product from the current order of list and make it to json
                            // await Navigator.push(
                            //   context, //thi is the await
                            //   MaterialPageRoute(
                            //     builder: (content) => BuyerDetailsScreen(
                            //       user: widget.user,
                            //       userProduct: userProduct,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.indigo,
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    "${PhpConfig().SERVER}/barterit/catches/${productList[index].productId}.png",
                                    // "https://picsum.photos/190/170",
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${productList[index].productId}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${productList[index].productCategory}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        "${productList[index].productLocality}",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "RM ${productList[index].productPrice}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (content) => PostProductScreen(user: widget.user),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void getProduct() {
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
