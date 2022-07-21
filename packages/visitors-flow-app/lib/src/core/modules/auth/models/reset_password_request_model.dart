class ResetPasswordRequestModel {
  String? email;
  String? token;
  String? password;

  ResetPasswordRequestModel({this.email, this.token, this.password});

  ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    token = json['token'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['token'] = this.token;
    data['password'] = this.password;
    return data;
  }
}
