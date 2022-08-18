class UserUpdatePasswordViewModel {
  UserUpdatePasswordViewModel({
    this.oldPassword,
    this.newPassword,
    this.id,
  });

  String? oldPassword;
  String? newPassword;
  String? id;

  Map<String, dynamic> toJson() => {
        'password': newPassword,
      };
}
