class TokenAndMessageModel {
  String? token;
  String? message;

  TokenAndMessageModel({this.token, this.message});

  TokenAndMessageModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}
