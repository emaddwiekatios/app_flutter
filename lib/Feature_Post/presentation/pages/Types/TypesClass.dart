class TypeClass {
  int TypeId;
  String TypeName;
  String TypePrice;
  String TypeCat;
  DateTime TypeEntryDate;
  String docsId;
  int TypeCount;
  TypeClass(
      {required this.TypeId,
      required this.TypeName,
      required this.TypePrice,
      required this.TypeCat,
      required this.TypeEntryDate,
      required this.docsId,
      required this.TypeCount});

  factory TypeClass.fromJson(Map<String, dynamic> json) {
    int TypeId = json['TypeId'];
    String TypeName = json['TypeName'];
    //String TypeImage = json['TypeImage'];
    String TypePrice = json['TypePrice'];
    String TypeCat = json['TypeCat'];
    DateTime TypeEntryDate = DateTime.parse(json['TypeEntryDate']);
    //int  favoriteFlag = json['favoriteFlag'];
    String docsId = json['docsId'];
    int TypeCount = json['TypeCount'];

    return TypeClass(
        TypeName: TypeName,
        TypePrice: TypePrice,
        TypeCat: TypeCat,
        TypeId: TypeId,
        TypeEntryDate: TypeEntryDate,
        docsId: docsId,
        TypeCount: TypeCount);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TypeId'] = TypeId;
    data['TypeName'] = TypeName;
    data['TypePrice'] = TypePrice;
    data['TypeCat'] = TypeCat;
    data['TypeEntryDate'] = TypeEntryDate;
    data['docsId'] = docsId;
    data['TypeCount'] = TypeCount;

    return data;
  }

  @override
  String toString() {
    return '"TypeClass" : { "TypeId": $TypeId,"TypeName": $TypeName, "TypePrice": $TypePrice ,"TypeEntryDate": $TypeEntryDate,"docsId":$docsId,"TypeCount":$TypeCount}';
  }
}
