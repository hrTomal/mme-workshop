class FeeInfo {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;
  int? totalPages;
  int? currentPage;

  FeeInfo(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.totalPages,
      this.currentPage});

  FeeInfo.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    return data;
  }
}

class Results {
  String? id;
  int? paymentAmount;
  Null? roomFeePayment;
  String? roomUser;
  RoomFee? roomFee;

  Results(
      {this.id,
      this.paymentAmount,
      this.roomFeePayment,
      this.roomUser,
      this.roomFee});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentAmount = json['payment_amount'];
    roomFeePayment = json['room_fee_payment'];
    roomUser = json['room_user'];
    roomFee = json['room_fee'] != null
        ? new RoomFee.fromJson(json['room_fee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_amount'] = this.paymentAmount;
    data['room_fee_payment'] = this.roomFeePayment;
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
