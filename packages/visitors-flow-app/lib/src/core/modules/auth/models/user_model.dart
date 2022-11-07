class UserModel {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? genre;
  List<String>? roles;

  UserModel(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.genre,
      this.roles});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    genre = json['genre'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['genre'] = genre;
    return data;
  }
}
