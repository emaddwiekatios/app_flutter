class TypeSummaryClass {
  String TypeCat;
  double Total;
  TypeSummaryClass({required this.TypeCat, required this.Total});

  factory TypeSummaryClass.fromJson(Map<String, dynamic> json) {
    String TypeCat = json['TypeCat'];
    double Total = json['Total'];

    return TypeSummaryClass(
      TypeCat: TypeCat,
      Total: Total,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['TypeCat'] = TypeCat;
    data['Total'] = Total;

    return data;
  }

  @override
  String toString() {
    return '"TypeSummaryClass" : {  "TypeCat": $TypeCat ,"Total": $Total}';
  }
}
