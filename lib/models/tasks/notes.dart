class Note {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;
  int? totalPages;
  int? currentPage;

  Note(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.totalPages,
      this.currentPage});

  Note.fromJson(Map<String, dynamic> json) {
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
  List<Files>? files;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? name;
  String? description;
  String? createdBy;
  String? updatedBy;
  String? roomSubject;

  Results(
      {this.id,
      this.files,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.name,
      this.description,
      this.createdBy,
      this.updatedBy,
      this.roomSubject});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    name = json['name'];
    description = json['description'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    roomSubject = json['room_subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['room_subject'] = this.roomSubject;
    return data;
  }
}

class Files {
  String? id;
  String? file;

  Files({this.id, this.file});

  Files.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    return data;
  }
}

class Comments {
  String? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? text;
  String? createdBy;
  String? updatedBy;
  String? user;
  String? note;

  Comments(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.text,
      this.createdBy,
      this.updatedBy,
      this.user,
      this.note});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    text = json['text'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    user = json['user'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['text'] = this.text;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['user'] = this.user;
    data['note'] = this.note;
    return data;
  }
}
