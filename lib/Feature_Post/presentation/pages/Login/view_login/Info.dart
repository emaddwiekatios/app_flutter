class Info {
  String token;
  String userId;
  String expiryDate;

  Info({required this.token, required this.userId, required this.expiryDate});

  factory Info.fromJson(Map<String, dynamic> json) {
    String token = json['token'];
    String userId = json['userId'];
    String expiryDate = json['expiryDate'];

    return Info(token: token, userId: userId, expiryDate: expiryDate);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;
    data['expiryDate'] = expiryDate;
    return data;
  }

  @override
  String toString() {
    return '"info" : { "token": $token, "userId": $userId, "expiryDate": $expiryDate}';
  }
}