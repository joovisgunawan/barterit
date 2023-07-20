import 'dart:convert';

import 'package:barterit/screens/paymentscreen.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

import '../phpconfig.dart';

class CartScreen extends StatefulWidget {
  final User user;
  // final Product userProduct;
  const CartScreen({super.key, required this.user});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> cartList = [];
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  double totalprice = 0.0;
  int maksQuantity = 0;
  @override
  void initState() {
    super.initState();
    loadcart();
    // maksQuantity = int.parse(widget.userProduct.productQuantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('cart'),
      ),
      body: cartList.isEmpty
          ? const Center(
              child: Text('empty'),
            )
          : Column(
              children: [
                Expanded(
                  flex: 4,
                  child: ListView.builder(
                    itemCount: cartList.length,
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
                                    // "${PhpConfig().SERVER}/barterit/photo/${widget.user.id}.png",
                                    "${PhpConfig().SERVER}/barterit/catches/${cartList[index].productId}.png",
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
                                        "${cartList[index].productName}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text("RM ${cartList[index].cartPrice}"),
                                      SizedBox(
                                        // color: Colors.black,
                                        width: 120,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                var cartQuantity = int.parse(
                                                    cartList[index]
                                                        .cartQuantity
                                                        .toString());
                                                var productPrice = double.parse(
                                                    cartList[index]
                                                        .productPrice
                                                        .toString());
                                                if (cartQuantity <= 1) {
                                                  print(cartQuantity);
                                                } else {
                                                  cartQuantity--;
                                                  double cartPrice =
                                                      productPrice *
                                                          cartQuantity;
                                                  updateCart(index,
                                                      cartQuantity, cartPrice);
                                                }

                                                // setState(() {});
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Text(
                                                  '${cartList[index].cartQuantity}'),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                int maksQuantity = int.parse(
                                                    cartList[index]
                                                        .productQuantity
                                                        .toString());
                                                int cartQuantity = int.parse(
                                                    cartList[index]
                                                        .cartQuantity
                                                        .toString());
                                                double productPrice =
                                                    double.parse(cartList[index]
                                                        .productPrice
                                                        .toString());
                                                if (cartQuantity >=
                                                    maksQuantity) {
                                                  print(cartQuantity);
                                                } else {
                                                  cartQuantity++;
                                                  double cartPrice =
                                                      productPrice *
                                                          cartQuantity;
                                                  updateCart(index,
                                                      cartQuantity, cartPrice);
                                                }

                                                // setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    int cartId = int.parse(
                                        cartList[index].cartId.toString());
                                    deletecart(cartId);
                                  },
                                  icon: const Icon(Icons.delete),
                                )
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
                            await Navigator.push(
                              context, //thi is the await
                              MaterialPageRoute(
                                builder: (content) => PaymentScreen(
                                  user: widget.user,
                                  cart: cartList,
                                  totalPrice: totalprice,
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

  void loadcart() {
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/getcart.php"),
        body: {
          "buyerId": widget.user.id,
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
          totalprice = 0;
          print(cartList.length);
          for (var element in cartList) {
            totalprice += double.parse(element.cartPrice.toString());
          }
          print(totalprice);
        }
        setState(() {});
      }
    });
  }

  void updateCart(int index, int cartQuantity, double cartPrice) {
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/editcart.php"),
        body: {
          "cartId": cartList[index].cartId,
          "cartQuantity": cartQuantity.toString(),
          "cartPrice": cartPrice.toString()
        }).then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          loadcart();
        } else {}
      } else {}
    });
  }

  void deletecart(int cartId) {
    // print(cartId);
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/deletecart.php"),
        body: {
          "cartId": cartId.toString(),
        }).then((response) {
      print(response.body);
      cartList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          print('succes retrive cart2');
          loadcart();
          print(cartList.length);
          // print(totalprice);
        }
        // setState(() {});
      }
    });
  }
}
