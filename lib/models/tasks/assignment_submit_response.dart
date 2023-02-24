class AssignmentSubmitResponse {
  String? id;
  String? mark;
  List<AssignmentSubmissionFiles>? assignmentSubmissionFiles;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? createdBy;
  String? updatedBy;
  RoomUser? roomUser;
  String? assignment;

  AssignmentSubmitResponse(
      {this.id,
      this.mark,
      this.assignmentSubmissionFiles,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.createdBy,
      this.updatedBy,
      this.roomUser,
      this.assignment});

  AssignmentSubmitResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mark = json['mark'];
    if (json['assignment_submission_files'] != null) {
      assignmentSubmissionFiles = <AssignmentSubmissionFiles>[];
      json['assignment_submission_files'].forEach((v) {
        assignmentSubmissionFiles!
            .add(new AssignmentSubmissionFiles.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    roomUser = json['room_user'] != null
        ? new RoomUser.fromJson(json['room_user'])
        : null;
    assignment = json['assignment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mark'] = this.mark;
    if (this.assignmentSubmissionFiles != null) {
      data['assignment_submission_files'] =
          this.assignmentSubmissionFiles!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.roomUser != null) {
      data['room_user'] = this.roomUser!.toJson();
    }
    data['assignment'] = this.assignment;
    return data;
  }
}

class AssignmentSubmissionFiles {
  String? file;

  AssignmentSubmissionFiles({this.file});

  AssignmentSubmissionFiles.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    return data;
  }
}

class RoomUser {
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

  RoomUser(
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

  RoomUser.fromJson(Map<String, dynamic> json) {
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
