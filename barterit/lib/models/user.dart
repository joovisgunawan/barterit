class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? gender;
  String? phone;
  String? address;
  String? photo;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.gender,
      this.phone,
      this.address,
      this.photo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    phone = json['phone'];
    address = json['address'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['gender'] = gender;
    data['phone'] = phone;
    data['address'] = address;
    data['photo'] = photo;
    return data;
  }
}
