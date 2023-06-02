class Record {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;
  int? totalPages;
  int? currentPage;

  Record(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.totalPages,
      this.currentPage});

  Record.fromJson(Map<String, dynamic> json) {
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
  String? file;
  Meeting? meeting;
  String? createdAt;
  String? updatedAt;

  Results({this.id, this.file, this.meeting, this.createdAt, this.updatedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    meeting =
        json['meeting'] != null ? new Meeting.fromJson(json['meeting']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    if (this.meeting != null) {
      data['meeting'] = this.meeting!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Meeting {
  String? id;
  String? name;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  String? lobbyName;

  Meeting(
      {this.id,
      this.name,
      this.description,
      this.date,
      this.startTime,
      this.endTime,
      this.lobbyName});

  Meeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['name'] = this.name;
    data['description'] = this.description;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['lobby_name'] = this.lobbyName;
    return data;
  }
}
