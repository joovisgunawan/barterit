class Cart {
  String? cartId;
  String? productId;
  String? productName;
  String? productCategory;
  String? productDescription;
  String? productQuantity;
  String? productPrice;
  String? userId;
  String? sellerId;

  Cart(
      {this.cartId,
      this.productId,
      this.productName,
      this.productCategory,
      this.productDescription,
      this.productQuantity,
      this.productPrice,
      this.userId,
      this.sellerId});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productCategory = json['product_category'];
    productDescription = json['product_description'];
    productQuantity = json['product_quantity'];
    productPrice = json['product_price'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_category'] = this.productCategory;
    data['product_description'] = this.productDescription;
    data['product_quantity'] = this.productQuantity;
    data['product_price'] = this.productPrice;
    data['user_id'] = this.userId;
    data['seller_id'] = this.sellerId;
    return data;
  }
}
