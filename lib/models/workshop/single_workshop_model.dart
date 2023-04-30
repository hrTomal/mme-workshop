class SingleWorkshopModel {
  String? id;
  SingleWorkshopModelInstructor? instructor;
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
  String? createdBy;
  String? updatedBy;

  SingleWorkshopModel(
      {this.id,
      required this.instructor,
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
      this.createdBy,
      this.updatedBy});
}

class SingleWorkshopModelInstructor {
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
  String? createdBy;
  String? updatedBy;
  String? teacher;

  SingleWorkshopModelInstructor(
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
}
