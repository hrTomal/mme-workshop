class FeeInfo {
  String? id;
  int? paymentAmount;
  String? roomUser;
  RoomFee? roomFee;

  FeeInfo({this.id, this.paymentAmount, this.roomUser, this.roomFee});

  FeeInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentAmount = json['payment_amount'];
    roomUser = json['room_user'];
    roomFee = json['room_fee'] != null
        ? new RoomFee.fromJson(json['room_fee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_amount'] = this.paymentAmount;
    data['room_user'] = this.roomUser;
    if (this.roomFee != null) {
      data['room_fee'] = this.roomFee!.toJson();
    }
    return data;
  }
}

class RoomFee {
  String? id;
  Fee? fee;
  String? feeMonth;
  bool? isActive;
  String? month;
  int? year;
  String? room;

  RoomFee(
      {this.id,
      this.fee,
      this.feeMonth,
      this.isActive,
      this.month,
      this.year,
      this.room});

  RoomFee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fee = json['fee'] != null ? new Fee.fromJson(json['fee']) : null;
    feeMonth = json['fee_month'];
    isActive = json['is_active'];
    month = json['month'];
    year = json['year'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.fee != null) {
      data['fee'] = this.fee!.toJson();
    }
    data['fee_month'] = this.feeMonth;
    data['is_active'] = this.isActive;
    data['month'] = this.month;
    data['year'] = this.year;
    data['room'] = this.room;
    return data;
  }
}

class Fee {
  String? id;
  String? name;
  String? amount;

  Fee({this.id, this.name, this.amount});

  Fee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}
