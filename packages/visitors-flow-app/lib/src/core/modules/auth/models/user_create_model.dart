class UserCreateModel {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserCreateModel(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserCreateModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
