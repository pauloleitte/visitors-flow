class UserModel {
  bool? auth;
  String? token;
  String? name;
  String? email;
  String? avatar;
  String? phone;
  String? password;
  String? id;

  UserModel(
      {this.auth,
      this.phone,
      this.token,
      this.name,
      this.email,
      this.password,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    token = json['token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    password = json['password'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth'] = auth;
    data['token'] = token;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['password'] = password;
    data['id'] = id;
    return data;
  }
}
