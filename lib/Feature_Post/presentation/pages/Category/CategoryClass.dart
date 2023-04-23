class CategoryClass {
  int catId;
  String catName;
  String catImage;
  String catPrice;
  String catDesc;
  DateTime catDate;
  String docsId;

  CategoryClass({required this.catId,required this.catName,required this.catImage, required this.catPrice,
    required this.catDesc,required this.catDate,required this.docsId});

  factory CategoryClass.fromJson(Map<String, dynamic> json) {
    int catId=json['catId'];
    String catName = json['catName'];
    String catimage = json['catimage'];
    String  catPrice = json['catPrice'];
    String catDesc = json['catDesc'];
    DateTime catDate = DateTime.parse(json['catDate']);
    String docsId = json['docsId'];


    return CategoryClass(catName: catName, catPrice: catPrice,
        catDesc: catDesc, catId: catId, catDate: catDate
        , catImage: catimage,docsId:docsId);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['catId'] = catId;
    data['catName'] = catName;
    data['catimage']= catImage;
    data['catPrice'] = catPrice;
    data['catDesc'] = catDesc;
    data['catDate'] = catDate;
    data['docsId'] = docsId;
    return data;
  }

  @override
  String toString() {
    return '"catClass" : { "catId": $catId,"catName": $catName,"catImage": $catImage, "catPrice": $catPrice , "catDate": $catDate,"docsId":$docsId  }';
  }
}