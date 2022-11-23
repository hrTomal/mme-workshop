class RoomInfo {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;
  int? totalPages;
  int? currentPage;

  RoomInfo(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.totalPages,
      this.currentPage});

  RoomInfo.fromJson(Map<String, dynamic> json) {
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
  bool? isAuthor;
  bool? isTeacher;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? name;
  String? code;
  bool? isAdministrationRoom;
  String? author;
  List<String>? categories;
  List<String>? user;

  Results(
      {this.id,
      this.isAuthor,
      this.isTeacher,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.name,
      this.code,
      this.isAdministrationRoom,
      this.author,
      this.categories,
      this.user});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isAuthor = json['is_author'];
    isTeacher = json['is_teacher'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    name = json['name'];
    code = json['code'];
    isAdministrationRoom = json['is_administration_room'];
    author = json['author'];
    categories = json['categories'].cast<String>();
    user = json['user'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_author'] = this.isAuthor;
    data['is_teacher'] = this.isTeacher;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['name'] = this.name;
    data['code'] = this.code;
    data['is_administration_room'] = this.isAdministrationRoom;
    data['author'] = this.author;
    data['categories'] = this.categories;
    data['user'] = this.user;
    return data;
  }
}
