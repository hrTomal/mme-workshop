class RoomInfo {
  int? count;
  Null? next;
  Null? previous;
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
  Subject? subject;
  String? description;
  String? room;
  bool? isTeacher;
  List<Teachers>? teachers;
  List<RoomSubjectTeachers>? roomSubjectTeachers;
  RoomDetails? roomDetails;

  Results(
      {this.id,
      this.subject,
      this.description,
      this.room,
      this.isTeacher,
      this.teachers,
      this.roomSubjectTeachers,
      this.roomDetails});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject =
        json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    description = json['description'];
    room = json['room'];
    isTeacher = json['is_teacher'];
    if (json['teachers'] != null) {
      teachers = <Teachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(new Teachers.fromJson(v));
      });
    }
    if (json['room_subject_teachers'] != null) {
      roomSubjectTeachers = <RoomSubjectTeachers>[];
      json['room_subject_teachers'].forEach((v) {
        roomSubjectTeachers!.add(new RoomSubjectTeachers.fromJson(v));
      });
    }
    roomDetails = json['room_details'] != null
        ? new RoomDetails.fromJson(json['room_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    data['description'] = this.description;
    data['room'] = this.room;
    data['is_teacher'] = this.isTeacher;
    if (this.teachers != null) {
      data['teachers'] = this.teachers!.map((v) => v.toJson()).toList();
    }
    if (this.roomSubjectTeachers != null) {
      data['room_subject_teachers'] =
          this.roomSubjectTeachers!.map((v) => v.toJson()).toList();
    }
    if (this.roomDetails != null) {
      data['room_details'] = this.roomDetails!.toJson();
    }
    return data;
  }
}

class Subject {
  String? id;
  String? title;
  String? description;

  Subject({this.id, this.title, this.description});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class Teachers {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? photo;
  String? phone;
  String? address;
  String? userType;
  bool? isActive;
  bool? isVerified;
  String? fullName;

  Teachers(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.photo,
      this.phone,
      this.address,
      this.userType,
      this.isActive,
      this.isVerified,
      this.fullName});

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    photo = json['photo'];
    phone = json['phone'];
    address = json['address'];
    userType = json['user_type'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['user_type'] = this.userType;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    data['full_name'] = this.fullName;
    return data;
  }
}

class RoomSubjectTeachers {
  String? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? createdBy;
  String? updatedBy;
  String? roomSubject;
  String? teacher;

  RoomSubjectTeachers(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.createdBy,
      this.updatedBy,
      this.roomSubject,
      this.teacher});

  RoomSubjectTeachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    roomSubject = json['room_subject'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['room_subject'] = this.roomSubject;
    data['teacher'] = this.teacher;
    return data;
  }
}

class RoomDetails {
  String? id;
  String? name;
  String? code;
  String? shift;
  String? section;
  String? session;

  RoomDetails(
      {this.id, this.name, this.code, this.shift, this.section, this.session});

  RoomDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    shift = json['shift'];
    section = json['section'];
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['shift'] = this.shift;
    data['section'] = this.section;
    data['session'] = this.session;
    return data;
  }
}

class RoomArguments {
  final String id;
  final Subject subject;
  final String description;
  final String room;

  RoomArguments(
    this.id,
    this.subject,
    this.description,
    this.room,
  );
}
