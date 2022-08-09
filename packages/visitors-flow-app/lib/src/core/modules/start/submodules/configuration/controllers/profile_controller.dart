import 'package:asuka/asuka.dart' as asuka;
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/services/interfaces/profile_service_interfaces.dart';

import '../../../../../config/app_messages.dart';
import '../../../../auth/models/user_model.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  bool busy = false;

  final IProfileService _service;

  _ProfileControllerBase(this._service);

  updatePassword() async {
    try {
      busy = true;
      var result = await _service.updatePassword(model);
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

  updateUser() async {
    try {
      busy = true;
      var result = await _service.updateUser(model);
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
}
