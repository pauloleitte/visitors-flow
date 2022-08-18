import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../config/app_messages.dart';
import '../../../../../auth/models/user_model.dart';
import '../../../../../auth/services/interfaces/user_service_interface.dart';
part 'configuration_controller.g.dart';

class ConfigurationController = _ConfigurationControllerBase
    with _$ConfigurationController;

abstract class _ConfigurationControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  bool busy = false;

  final IUserService _userService;

  _ConfigurationControllerBase(this._userService);

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
