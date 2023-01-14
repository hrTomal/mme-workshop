class Notice {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;
  int? totalPages;
  int? currentPage;

  Notice(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.totalPages,
      this.currentPage});

  Notice.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? content;
  String? type;
  Null? createdBy;
  Null? updatedBy;
  String? postedBy;

  Results(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.title,
      this.content,
      this.type,
      this.createdBy,
      this.updatedBy,
      this.postedBy});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    title = json['title'];
    content = json['content'];
    type = json['type'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    postedBy = json['posted_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['title'] = this.title;
    data['content'] = this.content;
    data['type'] = this.type;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['posted_by'] = this.postedBy;
    return data;
  }
}
