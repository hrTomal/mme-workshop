class MeetingRoom {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;
  int? totalPages;
  int? currentPage;

  MeetingRoom(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.totalPages,
      this.currentPage});

  MeetingRoom.fromJson(Map<String, dynamic> json) {
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
  Meeting? meeting;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? room;

  Results(
      {this.id,
      this.meeting,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.room});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meeting =
        json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.meeting != null) {
      data['meeting'] = this.meeting!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['room'] = this.room;
    return data;
  }
}

class Meeting {
  String? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? name;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  String? lobbyName;

  Meeting(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.name,
      this.description,
      this.date,
      this.startTime,
      this.endTime,
      this.lobbyName});

  Meeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    name = json['name'];
    description = json['description'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    lobbyName = json['lobby_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['name'] = this.name;
    data['description'] = this.description;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['lobby_name'] = this.lobbyName;
    return data;
  }
}
