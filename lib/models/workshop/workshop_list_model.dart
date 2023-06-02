class WorkshopListModel {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;
  int? totalPages;
  int? currentPage;

  WorkshopListModel(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.totalPages,
      this.currentPage});

  WorkshopListModel.fromJson(Map<String, dynamic> json) {
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
  Instructor? instructor;
  List<BatchRooms>? batchRooms;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? title;
  String? image;
  int? charge;
  int? chargeBefore;
  String? description;
  String? ledText;
  String? slug;
  String? wpUrl;
  int? priority;
  Null? createdBy;
  Null? updatedBy;
  Null? offeredBy;

  Results(
      {this.id,
      this.instructor,
      this.batchRooms,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.title,
      this.image,
      this.charge,
      this.chargeBefore,
      this.description,
      this.ledText,
      this.slug,
      this.wpUrl,
      this.priority,
      this.createdBy,
      this.updatedBy,
      this.offeredBy});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
    if (json['batch_rooms'] != null) {
      batchRooms = <BatchRooms>[];
      json['batch_rooms'].forEach((v) {
        batchRooms!.add(new BatchRooms.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    title = json['title'];
    image = json['image'];
    charge = json['charge'];
    chargeBefore = json['charge_before'];
    description = json['description'];
    ledText = json['led_text'];
    slug = json['slug'];
    wpUrl = json['wp_url'];
    priority = json['priority'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    offeredBy = json['offered_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.instructor != null) {
      data['instructor'] = this.instructor!.toJson();
    }
    if (this.batchRooms != null) {
      data['batch_rooms'] = this.batchRooms!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['title'] = this.title;
    data['image'] = this.image;
    data['charge'] = this.charge;
    data['charge_before'] = this.chargeBefore;
    data['description'] = this.description;
    data['led_text'] = this.ledText;
    data['slug'] = this.slug;
    data['wp_url'] = this.wpUrl;
    data['priority'] = this.priority;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['offered_by'] = this.offeredBy;
    return data;
  }
}

class Instructor {
  String? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? name;
  String? photo;
  String? designation;
  String? phone;
  String? email;
  String? paymentReceivingMethod;
  String? accountInformation;
  Null? createdBy;
  Null? updatedBy;
  String? teacher;

  Instructor(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.name,
      this.photo,
      this.designation,
      this.phone,
      this.email,
      this.paymentReceivingMethod,
      this.accountInformation,
      this.createdBy,
      this.updatedBy,
      this.teacher});

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    name = json['name'];
    photo = json['photo'];
    designation = json['designation'];
    phone = json['phone'];
    email = json['email'];
    paymentReceivingMethod = json['payment_receiving_method'];
    accountInformation = json['account_information'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    teacher = json['teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['designation'] = this.designation;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['payment_receiving_method'] = this.paymentReceivingMethod;
    data['account_information'] = this.accountInformation;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['teacher'] = this.teacher;
    return data;
  }
}

class BatchRooms {
  String? id;
  String? room;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? days;

  BatchRooms(
      {this.id,
      this.room,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.days});

  BatchRooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    room = json['room'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room'] = this.room;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['days'] = this.days;
    return data;
  }
}
