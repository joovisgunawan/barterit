import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../phpconfig.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import '../models/user.dart';

class PostProductScreen extends StatefulWidget {
  final User user;
  const PostProductScreen({super.key, required this.user});

  @override
  State<PostProductScreen> createState() => _PostProductScreenState();
}

class _PostProductScreenState extends State<PostProductScreen> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productCategory = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productQuantity = TextEditingController();
  final TextEditingController _productState = TextEditingController();
  final TextEditingController _productLocality = TextEditingController();
  // final TextEditingController _prstateEditingController =
  //     TextEditingController();
  // final TextEditingController _prlocalEditingController =
  // TextEditingController();
  // late Position _currentPosition;
  List productCategory = [
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
  String selectedCategory = "Electronics";

  String curaddress = "";
  String curstate = "";
  String prlat = "";
  String prlong = "";

  @override
  void initState() {
    super.initState();
    // _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('post'),
      ),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            _selectFromCamera();
          },
          child: Container(
            height: 200,
            width: double.infinity,
            color: Colors.blueAccent,
            child: const Text('camera'),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: Colors.blueGrey,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // name
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Name'),
                          TextFormField(
                            controller: _productName,
                            // validator: (value) {},
                          ),
                        ],
                      ),
                    ),
                    // Category
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Category'),
                          TextFormField(
                            controller: _productCategory,
                            // validator: (value) {},
                          ),
                        ],
                      ),
                    ),
                    // Description
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Description'),
                          TextFormField(
                            maxLines: 5,
                            controller: _productDescription,
                            // validator: (value) {},
                          ),
                        ],
                      ),
                    ),
                    // price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Price'),
                                TextFormField(
                                  controller: _productPrice,
                                  // validator: (value) {},
                                ),
                              ],
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Quantity'),
                                TextFormField(
                                  controller: _productQuantity,
                                  // validator: (value) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('State'),
                                TextFormField(
                                  controller: _productState,
                                  // validator: (value) {},
                                ),
                              ],
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Location'),
                                TextFormField(
                                  controller: _productLocality,
                                  // validator: (value) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          addProduct();
                        },
                        child: const Text("Post"))
                    // TextFormField(
                    //   controller: _productName,
                    //   validator: (value) {},
                    // ),
                    // // quantity
                    // TextFormField(
                    //   controller: _productName,
                    //   validator: (value) {},
                    // ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print(_image!.path);
      cropImage();
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        //CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio3x2,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      _image = imageFile;
      int? sizeInBytes = _image?.lengthSync();
      double sizeInMb = sizeInBytes! / (1024 * 1024);
      print(sizeInMb);

      setState(() {});
    }
  }

  // void _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location permissions are permanently denied.');
  //   }
  //   _currentPosition = await Geolocator.getCurrentPosition();

  //   _getAddress(_currentPosition);
  //   //return await Geolocator.getCurrentPosition();
  // }

  // _getAddress(Position position) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   if (placemarks.isEmpty) {
  //     _productLocality.text = "Changlun";
  //     _productState.text = "Kedah";
  //     prlat = "6.443455345";
  //     prlong = "100.05488449";
  //   } else {
  //     _productLocality.text = placemarks[0].locality.toString();
  //     _productState.text = placemarks[0].administrativeArea.toString();
  //     prlat = _currentPosition.latitude.toString();
  //     prlong = _currentPosition.longitude.toString();
  //   }
  //   setState(() {});
  // }

  void addProduct() {
    String productName = _productName.text;
    String productCategory = _productCategory.text;
    String productDescription = _productDescription.text;
    String productPrice = _productPrice.text;
    String productQuantity = _productQuantity.text;
    String productState = _productState.text;
    String productLocality = _productLocality.text;
    String base64Image = base64Encode(_image!.readAsBytesSync());

    print('succeess');
    http.post(
      Uri.parse("${PhpConfig().SERVER}/barterit/php/addproduct.php"),
      body: {
        'userId': widget.user.id.toString(),
        'productName': productName,
        'productCategory': productCategory,
        'productDescription': productDescription,
        'productPrice': productPrice,
        'productQuantity': productQuantity,
        'productState': productState,
        'productLocality': productLocality,
        "productImage": base64Image,
      },
    ).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        print('succeess');
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Insert Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Insert Failed")));
        }
      } else {
        print('failed');
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Insert Failed")));
      }
    });
  }
}
