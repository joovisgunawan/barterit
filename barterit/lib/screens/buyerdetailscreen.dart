import 'dart:convert';

// import 'package:barterit/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../phpconfig.dart';
import 'package:http/http.dart' as http;

class BuyerDetailsScreen extends StatefulWidget {
  final Product userProduct;
  final User user;
  const BuyerDetailsScreen(
      {super.key, required this.userProduct, required this.user});

  @override
  State<BuyerDetailsScreen> createState() => _BuyerDetailsScreenState();
}

class _BuyerDetailsScreenState extends State<BuyerDetailsScreen> {
  // late FocusNode myFocusNode;
  double totalPrice = 0.0;
  double singlePrice = 0.0;
  int maksQuantity = 0;
  int userQuantity = 1;

  @override
  void initState() {
    super.initState();
    userQuantity = 1;
    maksQuantity = int.parse(widget.userProduct.productQuantity.toString());
    totalPrice = double.parse(widget.userProduct.productPrice.toString());
    singlePrice = double.parse(widget.userProduct.productPrice.toString());
    // myFocusNode = FocusNode();
  }

  // final df = DateFormat('dd-MM-yyyy hh:mm a');

  late double screenHeight, screenWidth, cardwitdh;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Product Details'),
        elevation: 4,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 270,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(48),
                        // bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Image.network(
                      "${PhpConfig().SERVER}/barterit/catches/${widget.userProduct.productId}.png",
                    ),
                  ),
                  Container(
                    color: Colors.indigo,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(48),
                          // bottomRight: Radius.circular(32),
                        ),
                      ),
                      padding: EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.userProduct.productName}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.white,
                                ),
                              ),
                              Text(
                                "${widget.userProduct.productQuantity} Available",
                                style: const TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.favorite_border, size: 25),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (userQuantity <= 1) {
                                  userQuantity = 1;
                                } else {
                                  userQuantity--;
                                }
                                totalPrice = singlePrice * userQuantity;
                                setState(() {});
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Container(
                              child: Text(userQuantity.toString()),
                              // width: 30,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {});
                                if (userQuantity >= maksQuantity) {
                                  userQuantity = maksQuantity;
                                } else {
                                  userQuantity++;
                                }
                                totalPrice = singlePrice * userQuantity;
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'RM ' + totalPrice.toString(),
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                            // color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        Text("${widget.userProduct.productState}")
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${widget.userProduct.productDescription}")
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),

                  // Table(
                  //   children: [
                  //     TableRow(children: [
                  //       const TableCell(
                  //         child: Text(
                  //           "Stock",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //             // color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       TableCell(
                  //         child: Text(
                  //           "${widget.userProduct.productQuantity}",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //             // color: Colors.white,
                  //           ),
                  //         ),
                  //       )
                  //     ]),
                  //     TableRow(children: [
                  //       const TableCell(
                  //         child: Text(
                  //           "State",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //             // color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       TableCell(
                  //         child: Text(
                  //           "${widget.userProduct.productState}",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             // fontWeight: FontWeight.bold,
                  //             // color: Colors.white,
                  //           ),
                  //         ),
                  //       )
                  //     ]),
                  //     TableRow(children: [
                  //       const TableCell(
                  //         child: Text(
                  //           "Locality",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold,
                  //             // color: Colors.white,
                  //           ),
                  //         ),
                  //       ),
                  //       TableCell(
                  //         child: Text(
                  //           "${widget.userProduct.productLocality}",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //             // fontWeight: FontWeight.bold,
                  //             // color: Colors.white,
                  //           ),
                  //         ),
                  //       )
                  //     ]),
                  //   ],
                  // ),
                  // const Text(
                  //   "Description",
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //     // color: Colors.white,
                  //   ),
                  // ),
                  // Text(
                  //   "${widget.userProduct.productDescription}",
                  //   style: const TextStyle(
                  //     fontSize: 18,
                  //     // fontWeight: FontWeight.bold,
                  //     // color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                addtocart();
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
                'Add To Cart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       padding: const EdgeInsets.all(8),
          //       child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             IconButton(
          //                 onPressed: () {
          //                   if (int.parse(userQuantityController.text) <= 1) {
          //                     userQuantityController.text = 1.toString();
          //                     totalPrice = singlePrice *
          //                         int.parse(userQuantityController.text);
          //                   } else {
          //                     userQuantityController.text =
          //                         (int.parse(userQuantityController.text) - 1)
          //                             .toString();
          //                     totalPrice = singlePrice *
          //                         int.parse(userQuantityController.text);
          //                   }
          //                   setState(() {});
          //                 },
          //                 icon: const Icon(Icons.remove)),
          //             Container(
          //               width: 30,
          //               child: TextField(
          //                 onChanged: (value) {
          //                   if (int.parse(userQuantityController.text) <= 1) {
          //                     userQuantityController.text = 1.toString();
          //                     totalPrice = singlePrice *
          //                         int.parse(userQuantityController.text);
          //                   } else {
          //                     userQuantityController.text =
          //                         (int.parse(userQuantityController.text) - 1)
          //                             .toString();
          //                     totalPrice = singlePrice *
          //                         int.parse(userQuantityController.text);
          //                   }
          //                   setState(() {});
          //                 },
          //                 // focusNode: myFocusNode,
          //                 controller: userQuantityController,
          //               ),
          //             ),
          //             // Text(
          //             //   'gas',
          //             //   // userqty.toString(),
          //             //   style: const TextStyle(
          //             //       fontSize: 16, fontWeight: FontWeight.bold),
          //             // ),
          //             IconButton(
          //                 onPressed: () {
          //                   if (int.parse(userQuantityController.text) >=
          //                       maksQuantity) {
          //                     userQuantityController.text =
          //                         maksQuantity.toString();
          //                     totalPrice = singlePrice *
          //                         int.parse(userQuantityController.text);
          //                   } else {
          //                     userQuantityController.text =
          //                         (int.parse(userQuantityController.text) + 1)
          //                             .toString();
          //                     totalPrice = singlePrice *
          //                         int.parse(userQuantityController.text);
          //                   }
          //                   setState(() {});
          //                 },
          //                 icon: const Icon(Icons.add)),
          //           ]),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(16),
          //           topRight: Radius.circular(16)),
          //       color: Colors.black12),

          //   // color: Colors.black26,
          //   child: Row(
          //     children: [
          //       Container(
          //         width: 150,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text('Price'),
          //             Text(
          //               'RM ' + totalPrice.toString(),
          //               style: const TextStyle(
          //                 fontSize: 21,
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.orange,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: TextButton(
          //           onPressed: () {
          //             setState(() {});
          //             addtocart();
          //           },
          //           child: Text('Add To Cart'),
          //           style: TextButton.styleFrom(
          //             foregroundColor: Colors.white,
          //             backgroundColor: Colors.indigo,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void addtocart() {
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/addtocart.php"),
        body: {
          "productId": widget.userProduct.productId,
          "product_quantity": 3.toString(),
          "product_price": 4.toString(),
          "userId": widget.user.id,
          "sellerId": widget.userProduct.userId
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed")));
        Navigator.pop(context);
      }
    });
  }
}
