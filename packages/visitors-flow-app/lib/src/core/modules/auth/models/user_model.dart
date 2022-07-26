class UserModel {
  bool? auth;
  String? token;
  String? name;
  String? email;
  String? avatar;
  String? phone;

  UserModel({this.auth, this.token, this.name, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    token = json['token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth'] = auth;
    data['token'] = token;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    return data;
  }
}
