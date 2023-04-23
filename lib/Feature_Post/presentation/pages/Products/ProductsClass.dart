class ProductClass {
  int productId;
  String productName;
  String productImage;
  String productPrice;
  String productCat;
  DateTime productEntryDate;
  int favoriteFlag;
  String docsId;
  int productCount;
  ProductClass({required this.productId,required this.productName,required this.productImage, required this.productPrice,
    required this.productCat,required this.productEntryDate,required this.favoriteFlag,required this.docsId,required this.productCount});

  factory ProductClass.fromJson(Map<String, dynamic> json) {
    int productId=json['productId'];
    String productName = json['productName'];
    String productImage = json['productImage'];
    String  productPrice = json['productPrice'];
    String productCat = json['productCat'];
    DateTime productEntryDate = DateTime.parse(json['productEntryDate']);
    int  favoriteFlag = json['favoriteFlag'];
    String   docsId = json['docsId'];
    int  productCount = json['productCount'];

    return ProductClass(productName: productName, productPrice: productPrice, 
        productCat: productCat, productId: productId, productEntryDate: productEntryDate
        , productImage: productImage,favoriteFlag: favoriteFlag,docsId:docsId,productCount:productCount);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['productImage']= productImage;
    data['productPrice'] = productPrice;
    data['productCat'] = productCat;
    data['productEntryDate'] = productEntryDate;
    data['favoriteFlag'] =favoriteFlag;
    data['docsId'] =docsId;
    data['productCount']=productCount;

    return data;
  }

  @override
  String toString() {
    return '"ProductClass" : { "productId": $productId,"productName": $productName,"productImage": $productImage, "productPrice": $productPrice ,"productEntryDate": $productEntryDate,"favoriteFlag":$favoriteFlag,"docsId":$docsId,"productCount":$productCount}';
  }
}