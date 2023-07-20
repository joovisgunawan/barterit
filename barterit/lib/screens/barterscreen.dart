import 'dart:convert';

import 'package:barterit/screens/paymentscreen.dart';
import 'package:flutter/material.dart';

import '../models/barter.dart';
import '../models/cart.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

import '../phpconfig.dart';

class BarterScreen extends StatefulWidget {
  final User user;
  // final Product userProduct;
  const BarterScreen({super.key, required this.user});

  @override
  State<BarterScreen> createState() => _BarterScreenState();
}

class _BarterScreenState extends State<BarterScreen> {
  List barterList = [];
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  double totalprice = 0.0;
  int maksQuantity = 0;
  @override
  void initState() {
    super.initState();
    loadbarter();
    // maksQuantity = int.parse(widget.userProduct.productQuantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barter'),
      ),
      body: barterList.isEmpty
          ? const Center(
              child: Text('empty'),
            )
          : Column(
              children: [
                Expanded(
                  flex: 4,
                  child: ListView.builder(
                    itemCount: barterList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    "${PhpConfig().SERVER}/barterit/photo/${widget.user.id}.png",
                                    // "${PhpConfig().SERVER}/barterit/catches/${barterList[index].productId}.png",
                                    // width: double.infinity,
                                    width: 100,
                                  ),
                                ),
                                // Image.network(
                                //   "${PhpConfig().SERVER}/barterit/catches/${cartList[index].productId}.png",
                                //   // "https://picsum.photos/190/170",
                                //   width: 100,
                                // ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${barterList[index].sellerId}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text("RM ${barterList[index].barterId}"),
                                    ],
                                  ),
                                ),
                                // IconButton(
                                //   onPressed: () {
                                //     int cartId = int.parse(
                                //         barterList[index].cartId.toString());
                                //     // deletecart(cartId);
                                //   },
                                //   icon: const Icon(Icons.delete),
                                // )
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Price:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "RM$totalprice",
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () async {
                            // Cart cart = Cart.fromJson(
                            //   cartList.toJson(),
                            // ); //select the product from the current order of list and make it to json
                            // await Navigator.push(
                            //   context, //thi is the await
                            //   MaterialPageRoute(
                            //     builder: (content) => PaymentScreen(
                            //       user: widget.user,
                            //       cart: barterList,
                            //       totalPrice: totalprice,
                            //     ),
                            //   ),
                            // );
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
                          child: const Text('Pay Now'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void loadbarter() {
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/getbarter.php"),
        body: {
          "buyerId": widget.user.id,
        }).then((response) {
      print(response.body);
      barterList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          print('succes retrive cart2');
          var extractData = jsondata['data'];
          extractData['barter'].forEach((barter) {
            barterList.add(Barter.fromJson(barter));
          });
          // totalprice = 0;
          // print(cartList.length);
          // for (var element in cartList) {
          //   totalprice += double.parse(element.cartPrice.toString());
          // }
          // print(totalprice);
        }
        setState(() {});
      }
    });
  }

  void loadSellerProduct() {
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/getproduct.php"),
        body: {
          "buyerId": widget.user.id,
        }).then((response) {
      print(response.body);
      barterList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          print('succes retrive cart2');
          var extractData = jsondata['data'];
          extractData['barter'].forEach((barter) {
            barterList.add(Barter.fromJson(barter));
          });
          // totalprice = 0;
          // print(cartList.length);
          // for (var element in cartList) {
          //   totalprice += double.parse(element.cartPrice.toString());
          // }
          // print(totalprice);
        }
        setState(() {});
      }
    });
  }
}

  // void updateCart(int index, int cartQuantity, double cartPrice) {
  //   http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/editcart.php"),
  //       body: {
  //         "cartId": cartList[index].cartId,
  //         "cartQuantity": cartQuantity.toString(),
  //         "cartPrice": cartPrice.toString()
  //       }).then((response) {
  //     if (response.statusCode == 200) {
  //       var jsondata = jsonDecode(response.body);
  //       if (jsondata['status'] == 'success') {
  //         loadcart();
  //       } else {}
  //     } else {}
  //   });


  // void deletecart(int cartId) {
  //   // print(cartId);
  //   http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/deletecart.php"),
  //       body: {
  //         "cartId": cartId.toString(),
  //       }).then((response) {
  //     print(response.body);
  //     cartList.clear();
  //     if (response.statusCode == 200) {
  //       var jsondata = jsonDecode(response.body);
  //       if (jsondata['status'] == "success") {
  //         print('succes retrive cart2');
  //         loadcart();
  //         print(cartList.length);
  //         // print(totalprice);
  //       }
  //       // setState(() {});
  //     }
  //   });
  // }
// }
