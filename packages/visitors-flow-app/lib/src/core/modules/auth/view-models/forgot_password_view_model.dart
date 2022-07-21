import 'package:string_validator/string_validator.dart' as validator;

class ForgotPasswordViewModel {
  String? email = "";

  ForgotPasswordViewModel({this.email});

  bool get isValidEmail => validator.isEmail(email ?? "");
}
