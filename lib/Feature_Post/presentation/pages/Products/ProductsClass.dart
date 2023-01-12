class ProductClass {
  int productId;
  String productName;
  String productImage;
  double productPrice;
  String productCat;
  DateTime productEntryDate;

  ProductClass({required this.productId,required this.productName,required this.productImage, required this.productPrice, required this.productCat,required this.productEntryDate});

  factory ProductClass.fromJson(Map<String, dynamic> json) {
    int productId=json['productId'];
    String productName = json['productName'];
    String productImage = json['productImage'];
    double  productPrice = double.parse(json['productPrice']);
    String productCat = json['productCat'];
    DateTime productEntryDate = DateTime.parse(json['productEntryDate']);

    return ProductClass(productName: productName, productPrice: productPrice, 
        productCat: productCat, productId: productId, productEntryDate: productEntryDate
        , productImage: productImage);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['productImage']= productImage;
    data['productPrice'] = productPrice;
    data['productCat'] = productCat;
    data['productEntryDate'] = productEntryDate;
    return data;
  }

  @override
  String toString() {
    return '"ProductClass" : { "productId": $productId,"productName": $productName,"productImage": $productImage, "productPrice": $productPrice , "productEntryDate": $productEntryDate }';
  }
}