class UpdatePasswordModel {
  UpdatePasswordModel({
    this.oldPassword,
    this.newPassword,
    this.id,
  });

  final String? oldPassword;
  final String? newPassword;
  final String? id;

  Map<String, dynamic> toJson() => {
        'password': newPassword,
      };
}
