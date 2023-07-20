class Barter {
  String? barterId;
  String? sellerProductId;
  String? buyerProductId;
  String? sellerId;
  String? buyerId;

  Barter(
      {this.barterId,
      this.sellerProductId,
      this.buyerProductId,
      this.sellerId,
      this.buyerId});

  Barter.fromJson(Map<String, dynamic> json) {
    barterId = json['barter_id'];
    sellerProductId = json['seller_product_id'];
    buyerProductId = json['buyer_product_id'];
    sellerId = json['seller_id'];
    buyerId = json['buyer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barter_id'] = this.barterId;
    data['seller_product_id'] = this.sellerProductId;
    data['buyer_product_id'] = this.buyerProductId;
    data['seller_id'] = this.sellerId;
    data['buyer_id'] = this.buyerId;
    return data;
  }
}
