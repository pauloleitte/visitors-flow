class UserModel {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? password;
  List<String>? roles;

  UserModel(
      {this.sId, this.name, this.email, this.phone, this.password, this.roles});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
