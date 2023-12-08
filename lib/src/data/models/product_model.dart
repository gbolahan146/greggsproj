class ProductModel {
  String? articleCode;
  String? shopCode;
  String? availableFrom;
  String? availableUntil;
  double? eatOutPrice;
  double? eatInPrice;
  String? articleName;
  List<String>? dayParts;
  String? internalDescription;
  String? customerDescription;
  String? imageUri;
  String? thumbnailUri;

  ProductModel(
      {this.articleCode,
      this.shopCode,
      this.availableFrom,
      this.availableUntil,
      this.eatOutPrice,
      this.eatInPrice,
      this.articleName,
      this.dayParts,
      this.internalDescription,
      this.customerDescription,
      this.imageUri,
      this.thumbnailUri});

  ProductModel.fromJson(Map<String, dynamic> json) {
    articleCode = json['articleCode'];
    shopCode = json['shopCode'];
    availableFrom = json['availableFrom'];
    availableUntil = json['availableUntil'];
    eatOutPrice = json['eatOutPrice'];
    eatInPrice = json['eatInPrice'];
    articleName = json['articleName'];
    dayParts = json['dayParts'].cast<String>();
    internalDescription = json['internalDescription'];
    customerDescription = json['customerDescription'];
    imageUri = json['imageUri'];
    thumbnailUri = json['thumbnailUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['articleCode'] = articleCode;
    data['shopCode'] = shopCode;
    data['availableFrom'] = availableFrom;
    data['availableUntil'] = availableUntil;
    data['eatOutPrice'] = eatOutPrice;
    data['eatInPrice'] = eatInPrice;
    data['articleName'] = articleName;
    data['dayParts'] = dayParts;
    data['internalDescription'] = internalDescription;
    data['customerDescription'] = customerDescription;
    data['imageUri'] = imageUri;
    data['thumbnailUri'] = thumbnailUri;
    return data;
  }
}
