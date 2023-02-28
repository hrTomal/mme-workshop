class PaymentHistoryModel {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;
  int? totalPages;
  int? currentPage;

  PaymentHistoryModel(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.totalPages,
      this.currentPage});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? amount;
  Null? createdBy;
  Null? updatedBy;
  String? transaction;

  Results(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.amount,
      this.createdBy,
      this.updatedBy,
      this.transaction});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    amount = json['amount'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    transaction = json['transaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['amount'] = this.amount;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['transaction'] = this.transaction;
    return data;
  }
}
