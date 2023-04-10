class CategoryClass {
  int Cat_Id;
  String Cat_Name;
  String Cat_image;
  String Cat_Price;
  String Cat_Desc;
  DateTime Cat_Date;
 

  CategoryClass({required this.Cat_Id,required this.Cat_Name,required this.Cat_image, required this.Cat_Price,
    required this.Cat_Desc,required this.Cat_Date});

  factory CategoryClass.fromJson(Map<String, dynamic> json) {
    int Cat_Id=json['Cat_Id'];
    String Cat_Name = json['Cat_Name'];
    String Cat_image = json['Cat_image'];
    String  Cat_Price = json['Cat_Price'];
    String Cat_Desc = json['Cat_Desc'];
    DateTime Cat_Date = DateTime.parse(json['Cat_Date']);
  


    return CategoryClass(Cat_Name: Cat_Name, Cat_Price: Cat_Price,
        Cat_Desc: Cat_Desc, Cat_Id: Cat_Id, Cat_Date: Cat_Date
        , Cat_image: Cat_image);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Cat_Id'] = Cat_Id;
    data['Cat_Name'] = Cat_Name;
    data['Cat_image']= Cat_image;
    data['Cat_Price'] = Cat_Price;
    data['Cat_Desc'] = Cat_Desc;
    data['Cat_Date'] = Cat_Date;
   
    return data;
  }

  @override
  String toString() {
    return '"Cat_Class" : { "Cat_Id": $Cat_Id,"Cat_Name": $Cat_Name,"Cat_image": $Cat_image, "Cat_Price": $Cat_Price , "Cat_Date": $Cat_Date  }';
  }
}