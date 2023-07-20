// import 'package:barterit/screens/signinscreen.dart';
import 'package:barterit/screens/barterscreen.dart';
import 'package:barterit/screens/homescreen.dart';
import 'package:barterit/screens/sellerscreen.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'screens/buyerproductscreen.dart';
import 'screens/profilescreen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  final int index;
  const MainScreen({super.key, required this.user, required this.index});

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  final myController = TextEditingController();
  late List tabchildren;
  int _currentIndex = 0;
  String title = "Home Screen";

  // List store = new List();
  @override
  void initState() {
    super.initState();
    tabchildren = [
      HomeScreen(user: widget.user),
      SellerScreen(user: widget.user),
      BarterScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];
    _currentIndex = widget.index;
    // myController.text = total.toString();
    // print(widget.user.name);
  }

  var total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      body: tabchildren[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            selectedIndex: widget.index,
            backgroundColor: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.indigo,
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.add,
                text: 'Post',
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Notification',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            onTabChange: (value) {
              // onTabTapped(value);
              _currentIndex = value;
              setState(() {});
            },
          ),
        ),
      ),
    );

    // body: Container(
    //   // color: Colors.blue,
    //   child: Column(children: [
    //     //hi
    //     //total credit like tng
    //     //carousel
    //     //
    //     Text('Hi ${widget.user.name.toString()}'),
    //     // TextField(
    //     //   controller: myController,
    //     // ),
    //     // TextButton(
    //     //   onPressed: gas,
    //     //   child: Text("gas"),
    //     // ),
    //     TextField(
    //       controller: myController,
    //     ),
    //     Row(
    //       children: [
    //         IconButton(
    //           onPressed: () {
    //             // var currentQty = int.parse(myController.text);
    //             // int.parse(myController.text);
    //             // myController.text = total;
    //             // currentQty++;
    //             myController.text =
    //                 (int.parse(myController.text) + 1).toString();
    //             print(myController.text);
    //             total = int.parse(myController.text);

    //             setState(() {});
    //           },
    //           icon: Icon(Icons.add),
    //         ),
    //         IconButton(
    //           onPressed: () {
    //             // var currentQty = int.parse(myController.text);
    //             // int.parse(myController.text);
    //             // myController.text = total;
    //             // currentQty++;
    //             myController.text =
    //                 (int.parse(myController.text) - 1).toString();
    //             print(myController.text);

    //             total = int.parse(myController.text);

    //             setState(() {});
    //           },
    //           icon: Icon(Icons.remove),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             total = int.parse(myController.text);
    //             setState(() {});
    //           },
    //           child: Text('save'),
    //         ),
    //       ],
    //     ),
    //     Text(total.toString()),

    //     Expanded(
    //       child: ListView.builder(
    //         scrollDirection: Axis.vertical,
    //         itemCount: total,
    //         itemBuilder: (BuildContext context, int index) {
    //           return Container(
    //             // width: 100,
    //             height: 100,
    //             // color: Colors.amber,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(8),
    //               border: Border.all(color: Colors.indigo),
    //               color: Color.fromARGB(255, 212, 215, 234),
    //             ),

    //             // padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    //             margin: EdgeInsets.all(8),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Container(
    //                   width: 50,
    //                   height: 100,
    //                   color: Colors.black,
    //                 ),
    //                 Column(
    //                   children: [
    //                     Text('This is The title' + index.toString()),
    //                     Text('This is The description' + index.toString()),
    //                     Row(
    //                       children: [
    //                         IconButton(
    //                           onPressed: () {
    //                             // var currentQty = int.parse(myController.text);
    //                             // int.parse(myController.text);
    //                             // myController.text = total;
    //                             // currentQty++;
    //                             myController.text =
    //                                 (int.parse(myController.text) + 1)
    //                                     .toString();
    //                             print(myController.text);
    //                             total = int.parse(myController.text);

    //                             setState(() {});
    //                           },
    //                           icon: Icon(Icons.add),
    //                         ),
    //                         Text(total.toString()),
    //                         IconButton(
    //                           onPressed: () {
    //                             // var currentQty = int.parse(myController.text);
    //                             // int.parse(myController.text);
    //                             // myController.text = total;
    //                             // currentQty++;
    //                             myController.text =
    //                                 (int.parse(myController.text) + 1)
    //                                     .toString();
    //                             print(myController.text);
    //                             total = int.parse(myController.text);

    //                             setState(() {});
    //                           },
    //                           icon: Icon(Icons.remove),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //                 IconButton(
    //                   onPressed: () {
    //                     // var currentQty = int.parse(myController.text);
    //                     // int.parse(myController.text);
    //                     // myController.text = total;
    //                     // currentQty++;
    //                     myController.text =
    //                         (int.parse(myController.text) - 1).toString();
    //                     print(myController.text);
    //                     total = int.parse(myController.text);

    //                     setState(() {});
    //                   },
    //                   icon: Icon(Icons.delete),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //     Container(
    //       padding: EdgeInsets.all(16),
    //       color: Colors.indigo,
    //       child: Column(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 'Total',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 24,
    //                 ),
    //               ),
    //               Text(
    //                 'RM' + (total * 10).toString(),
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 24,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => SignInScreen(),
    //                 ),
    //               );
    //             },
    //             style: TextButton.styleFrom(
    //               primary: Colors.indigo,
    //               backgroundColor: Color(0xffF7FFF7),
    //               minimumSize: Size.fromHeight(50),
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(8),
    //               ),
    //               side: const BorderSide(
    //                 color: Colors.indigo,
    //                 style: BorderStyle.solid,
    //               ),
    //             ),
    //             child: const Text('Check Out'),
    //           ),
    //         ],
    //       ),
    //     )
    //   ]),
    // ),
  }

  // void onTabTapped(int value) {
  //   _currentIndex = value;
  // if (_currentIndex == 0) {
  //   title = "Buyer";
  // }
  // if (_currentIndex == 1) {
  //   title = "Seller";
  // }
  // if (_currentIndex == 2) {
  //   title = "Profile";
  // }
  // if (_currentIndex == 3) {
  //   title = "News";
  // }
  // }
}
