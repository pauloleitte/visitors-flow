import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/modules/auth/models/token_model.dart';
import 'package:visitors_flow_app/src/core/modules/auth/services/interfaces/token_service_interface.dart';

import '../../../../../../config/app_messages.dart';
import '../../../../../auth/models/user_model.dart';
import '../../../../../auth/services/interfaces/user_service_interface.dart';
part 'configuration_controller.g.dart';

// ignore: library_private_types_in_public_api
class ConfigurationController = _ConfigurationControllerBase
    with _$ConfigurationController;

abstract class _ConfigurationControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  bool busy = false;

  final IUserService _userService;
  final ITokenService _tokenService;

  _ConfigurationControllerBase(this._userService, this._tokenService);

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

  logout() async {
    await _userService.saveLocalDB(UserModel());
    await _tokenService.saveLocalDB(TokenModel());
  }
}
