// {
//     "id": "43f3154c42b74489a9e901546e4b1d0e",
//     "username": "yeamin21",
//     "email": "",
//     "name": "",
//     "photo": null,
//     "phone": "01954492600",
//     "address": null,
//     "user_type": "REGULAR"
// }

class User {
  late final String id;
  late final String username;
  late final String? email;
  late final String? name;
  late final String? photo;
  late final String? phone;
  late final String? address;
  late final String? user_type;

  User(
    this.id,
    this.username,
    this.email,
    this.name,
    this.photo,
    this.phone,
    this.address,
    this.user_type,
  );

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    photo = json['photo'];
    phone = json['phone'];
    address = json['address'];
    user_type = json['user_type'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['name'] = name;
    _data['photo'] = photo;
    _data['phone'] = phone;
    _data['address'] = address;
    _data['user_type'] = user_type;

    return _data;
  }
}
