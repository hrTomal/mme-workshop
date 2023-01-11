class AamarPayUrl {
  String? result;
  String? paymentUrl;

  AamarPayUrl({this.result, this.paymentUrl});

  AamarPayUrl.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['payment_url'] = this.paymentUrl;
    return data;
  }
}
