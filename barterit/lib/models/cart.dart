class Cart {
  String? cartId;
  String? productId;
  String? productName;
  String? productCategory;
  String? productDescription;
  String? productQuantity;
  String? productPrice;
  String? cartQuantity;
  String? cartPrice;
  String? buyerId;
  String? sellerId;

  Cart(
      {this.cartId,
      this.productId,
      this.productName,
      this.productCategory,
      this.productDescription,
      this.productQuantity,
      this.productPrice,
      this.cartQuantity,
      this.cartPrice,
      this.buyerId,
      this.sellerId});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productCategory = json['product_category'];
    productDescription = json['product_description'];
    productQuantity = json['product_quantity'];
    productPrice = json['product_price'];
    cartQuantity = json['cart_quantity'];
    cartPrice = json['cart_price'];
    buyerId = json['buyer_id'];
    sellerId = json['seller_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_category'] = productCategory;
    data['product_description'] = productDescription;
    data['product_quantity'] = productQuantity;
    data['product_price'] = productPrice;
    data['cart_quantity'] = cartQuantity;
    data['cart_price'] = cartPrice;
    data['buyer_id'] = buyerId;
    data['seller_id'] = sellerId;
    return data;
  }
}
