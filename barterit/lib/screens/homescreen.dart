import 'dart:convert';

import 'package:barterit/screens/buyerdetailscreen.dart';
// import 'package:barterit/screens/postproductscreen.dart';
// import 'package:barterit/screens/sellerscreen.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/user.dart';
import '../phpconfig.dart';
import 'package:http/http.dart' as http;

import 'cartscreen.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List productList = [];
  List productCategories = [
    "For You",
    "Electronics",
    "Fashion and Clothing",
    "Home and Kitchen",
    "Sports and Fitness",
    "Health and Beauty",
    "Books and Media",
    "Toys and Games",
    "Automotive",
    "Baby and Kids",
    "Pet Supplies",
  ];
  String selectedCategories = "For You";
  String maintitle = "Buyer";
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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi ${widget.user.name.toString()}',
          style: const TextStyle(
              color: Colors.indigo, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              searchDialog();
            },
          ),
          TextButton.icon(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (content) => CartScreen(
                    user: widget.user,
                  ),
                ),
              );
            },
            label: const Text('cart'),
          )
        ],
      ),
      // body: productList.isEmpty
      // ? const Center(
      //     child: Text("No Data"),
      //   )
      // : Column(
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productCategories.length,
              itemBuilder: (context, index) {
                if (productCategories[index] == selectedCategories) {
                  color1 = Colors.indigo;
                } else {
                  color1 = Colors.black38;
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      selectedCategories = productCategories[index];
                      category(selectedCategories);
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: color1,
                      ),
                      child: Center(
                        child: Text(
                          productCategories[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
                              //asyn measn there is await there
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
                      // print(currentPage);
                      // setState(() {});
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
    );
  }

  void getProduct(int currentPage) {
    // if (widget.user.id == "na") {
    //   setState(() {
    //     // titlecenter = "Unregistered User";
    //   });
    //   return;
    // }
    http.post(
      Uri.parse("${PhpConfig().SERVER}/barterit/php/getproduct.php"),
      body: {
        // 'selected_category': selectedCategories,
        'current_page': currentPage.toString(),
      },
    ).then((response) {
      // print(response.body);
      productList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          var extractData = jsondata['data'];
          extractData['product'].forEach((product) {
            productList.add(Product.fromJson(product));
          });
          totalPage = jsondata['totalPage'];
        }
        setState(() {});
        // print(selectedPage);
        print(currentPage);
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

  void category(String category) {
    http.post(Uri.parse("${PhpConfig().SERVER}/barterit/php/getproduct.php"),
        body: {
          "product_category": category,
        }).then((response) {
      print(1);
      // log(response.body);
      productList.clear();
      print(2);
      if (response.statusCode == 200) {
        // print(3);
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['product'].forEach((v) {
            productList.add(Product.fromJson(v));
          });
          print(4);
          // print(productList[0].productPrice);
        }
        setState(() {});
      }
    });
  }
}
