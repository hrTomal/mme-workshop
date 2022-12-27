class User {
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

  User(
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
      this.isVerified});

  User.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
