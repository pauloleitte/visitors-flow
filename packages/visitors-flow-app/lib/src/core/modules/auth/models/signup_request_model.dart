class SignupRequestModel {
  String? email;
  String? password;
  String? name;
  String? phone;

  SignupRequestModel({this.email, this.password, this.name, this.phone});

  SignupRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
