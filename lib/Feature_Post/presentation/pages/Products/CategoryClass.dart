class CategoryClass {
  int categoryId;
  String categoryName;
  String categoryImage;
  DateTime categoryEntryDate;

  CategoryClass({required this.categoryId,required this.categoryName,required this.categoryImage, required this.categoryEntryDate});

  factory CategoryClass.fromJson(Map<String, dynamic> json) {
    int categoryId=json['categoryId'];
    String categoryName = json['categoryName'];
    String categoryImage = json['categoryImage'];
    double  categoryPrice = double.parse(json['categoryPrice']);
    String categoryCat = json['categoryCat'];
    DateTime categoryEntryDate = DateTime.parse(json['categoryEntryDate']);

    return CategoryClass(categoryName: categoryName,
       categoryId: categoryId, categoryEntryDate: categoryEntryDate
        , categoryImage: categoryImage);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['categoryImage']= categoryImage;
    data['categoryEntryDate'] = categoryEntryDate;
    return data;
  }

  @override
  String toString() {
    return '"CategoryClass" : { "categoryId": $categoryId,"categoryName": $categoryName,"categoryImage": $categoryImage,  "categoryEntryDate": $categoryEntryDate }';
  }
}