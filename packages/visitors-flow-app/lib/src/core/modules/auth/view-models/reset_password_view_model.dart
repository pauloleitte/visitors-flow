class ResetPasswordViewModel {
  String? email = "";
  String? token = "";
  String? password = "";
  String? confirmPassword = "";

  ResetPasswordViewModel({this.email, this.password, this.token, this.confirmPassword});

  bool get isValidPassword =>
      (password != null && password!.isNotEmpty && password!.length >= 3);

  bool get isValidConfirmPassword =>
      (confirmPassword != null && confirmPassword == password);
}
