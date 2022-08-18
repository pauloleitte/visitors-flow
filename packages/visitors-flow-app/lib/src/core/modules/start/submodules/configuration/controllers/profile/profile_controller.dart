import 'package:asuka/asuka.dart' as asuka;
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

import '../../../../../../config/app_messages.dart';
import '../../../../../auth/models/user_model.dart';
import '../../../../../auth/services/interfaces/user_service_interface.dart';
import '../../view-models/user_view_model.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @computed
  UserViewModel get vm => UserViewModel(
        id: model.sId,
        name: model.name,
        email: model.email,
        phone: model.phone,
      );

  @observable
  bool busy = false;

  final IUserService _userService;

  _ProfileControllerBase(this._userService);

  updateUser() async {
    try {
      busy = true;
      var result = await _userService.updateUser(vm);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (user) async {
        await _userService.saveLocalDB(user);
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
      var result = await _userService.getUser();
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (user) {
        model = user;
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
}
