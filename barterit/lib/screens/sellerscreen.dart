import 'dart:convert';

import 'package:barterit/screens/postproductscreen.dart';
// import 'package:barterit/screens/signinscreen.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

import '../phpconfig.dart';
import 'buyerdetailscreen.dart';
import 'cartscreen.dart';
// import 'signinscreen.dart';

class SellerScreen extends StatefulWidget {
  final User user;

  const SellerScreen({super.key, required this.user});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  List productList = [];
  TextEditingController searchController = TextEditingController();
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  int totalPage = 1, currentPage = 1;
  int numberofresult = 0;
  var color, color1;
  int cartqty = 0;

  @override
  void initState() {
    super.initState();
    getProduct(currentPage);
  }

  // List productList = [];
  // String title = 'Seller';
  // @override
  // void initState() {
  //   super.initState();
  //   getProduct();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller'),
        automaticallyImplyLeading: false,
      ),
      // body: productList.isEmpty
      // ? const Center(
      //     child: Text("No Data"),
      //   )
      // : Column(
      body: Column(
        children: [
          Expanded(
            child: productList.isEmpty
                ? const Center(
                    child: Text('No data'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: productList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 350,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () async {
                              Product userProduct = Product.fromJson(
                                productList[index].toJson(),
                              ); //select the product from the current order of list and make it to json
                              await Navigator.push(
                                context, //thi is the await
                                MaterialPageRoute(
                                  builder: (content) => BuyerDetailsScreen(
                                    user: widget.user,
                                    userProduct: userProduct,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 350,
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
                                          "${productList[index].productName}",
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
                                          "${productList[index].productState}",
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
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: totalPage,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                //build the list for textbutton with scroll
                if ((currentPage - 1) == index) {
                  color = Colors.indigo;
                } else {
                  color = Colors.grey;
                }
                return TextButton(
                    onPressed: () {
                      currentPage = index + 1;
                      getProduct(currentPage);
                    },
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: color, fontSize: 18),
                    ));
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

  void searchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Search",
            style: TextStyle(),
          ),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                    ))),
            const SizedBox(
              height: 4,
            ),
            ElevatedButton(
                onPressed: () {
                  String searchKey = searchController.text;
                  search(searchKey);
                  Navigator.of(context).pop();
                },
                child: const Text("Search"))
          ]),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void search(String searchKey) {
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/getproduct.php"),
        body: {
          "search_key": searchKey,
        }).then((response) {
      // print(1);
      // log(response.body);
      productList.clear();
      // print(2);
      if (response.statusCode == 200) {
        // print(3);
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['product'].forEach((v) {
            productList.add(Product.fromJson(v));
          });
          // print(4);
          print(productList[0].productPrice);
        }
        setState(() {});
      }
    });
  }
}
