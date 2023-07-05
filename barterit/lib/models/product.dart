class Product {
  String? productId;
  String? userId;
  String? productName;
  String? productCategory;
  String? productDescription;
  String? productPrice;
  String? productQuantity;
  // String? productLat;
  String? productLong;
  String? productState;
  String? productLocality;
  // String? productDate;

  Product({
    this.productId,
    this.userId,
    this.productName,
    this.productCategory,
    this.productDescription,
    this.productPrice,
    this.productQuantity,
    // this.productLat,
    // this.productLong,
    this.productState,
    this.productLocality,
    // this.productDate
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    userId = json['user_id'];
    productName = json['product_name'];
    productCategory = json['product_category'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productQuantity = json['product_quantity'];
    // productLat = json['product_lat'];
    // productLong = json['product_long'];
    productState = json['product_state'];
    productLocality = json['product_locality'];
    // productDate = json['product_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['product_name'] = productName;
    data['product_category'] = productCategory;
    data['product_description'] = productDescription;
    data['product_price'] = productPrice;
    data['product_quantity'] = productQuantity;
    // data['product_lat'] = productLat;
    // data['product_long'] = productLong;
    data['product_state'] = productState;
    data['product_locality'] = productLocality;
    // data['product_date'] = productDate;
    return data;
  }
}
