class UserModel {
  String? name;
  String? email;
  String? phone;
  String? id;

  UserModel({this.phone, this.name, this.email, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['id'] = id;
    return data;
  }
}
