import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/app_messages.dart';
import '../../../../../../config/app_routes.dart';
import '../../../../../auth/models/user_model.dart';
import '../../../../../auth/services/interfaces/user_service_interface.dart';
import '../../view-models/user_update_password_view_model.dart';
part 'security_controller.g.dart';

class SecurityController = _SecurityControllerBase with _$SecurityController;

abstract class _SecurityControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  bool busy = false;

  @computed
  UserUpdatePasswordViewModel get vmPassword => UserUpdatePasswordViewModel(
        id: model.sId,
        oldPassword: model.password,
        newPassword: model.password,
      );

  final IUserService _userService;

  _SecurityControllerBase(this._userService);

  updatePassword() async {
    try {
      busy = true;
      var result = await _userService.updatePassword(vmPassword);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (user) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.CONFIG);
      });
    } catch (e) {
      asuka.showSnackBar(const SnackBar(
          content: Text(
        AppMessages.ERROR_MESSAGE,
      )));
    } finally {
      busy = false;
    }
  }

  getUser() async {
    try {
      busy = true;
      var result = await _userService.getCurrentUser();
      model = result;
    } catch (e) {
      asuka.showSnackBar(const SnackBar(
          content: Text(
        AppMessages.ERROR_MESSAGE,
      )));
    } finally {
      busy = false;
    }
  }
}
