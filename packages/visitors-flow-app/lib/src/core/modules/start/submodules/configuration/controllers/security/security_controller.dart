import 'package:asuka/asuka.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/view-models/user_view_model.dart';

import '../../../../../../config/app_messages.dart';
import '../../../../../../config/app_routes.dart';
import '../../../../../auth/models/user_model.dart';
import '../../../../../auth/services/interfaces/user_service_interface.dart';
part 'security_controller.g.dart';

// ignore: library_private_types_in_public_api
class SecurityController = _SecurityControllerBase with _$SecurityController;

abstract class _SecurityControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  bool busy = false;

  @computed
  UserViewModel get vm => UserViewModel(
      id: model.sId,
      password: model.password,
      email: model.email,
      name: model.name,
      phone: model.phone);

  final IUserService _userService;

  _SecurityControllerBase(this._userService);

  updatePassword() async {
    try {
      busy = true;
      var result = await _userService.updatePassword(vm);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (user) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.CONFIG);
      });
    } catch (e) {
      Asuka.showSnackBar(const SnackBar(
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
      Asuka.showSnackBar(const SnackBar(
          content: Text(
        AppMessages.ERROR_MESSAGE,
      )));
    } finally {
      busy = false;
    }
  }
}
