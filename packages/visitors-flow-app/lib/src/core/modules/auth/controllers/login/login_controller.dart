import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/config/app_messages.dart';
import 'package:visitors_flow_app/src/core/modules/auth/stores/token_store.dart';

import '../../../../config/app_routes.dart';
import '../../services/user_service.dart';
import '../../stores/user_store.dart';
import '../../view-models/login_view_model.dart';
part 'login_controller.g.dart';

// ignore: library_private_types_in_public_api
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  bool busy = false;

  UserService service;
  UserStore userStore;
  TokenStore tokenStore;

  _LoginControllerBase(this.service, this.userStore, this.tokenStore);

  @computed
  LoginViewModel get model => LoginViewModel(email: email, password: password);

  Future<void> login() async {
    try {
      busy = true;
      var result = await service.login(model);
      result.fold((failure) {
        Asuka.showSnackBar(SnackBar(
            content: Text(failure.message ?? AppMessages.ERROR_HTTP_MESSAGE)));
      }, (token) {
        tokenStore.setToken(token);
        Modular.to.navigate(AppRoutes.HOME);
      });
    } catch (e) {
      busy = false;
      Asuka.showSnackBar(
          const SnackBar(content: Text(AppMessages.ERROR_HTTP_MESSAGE)));
    } finally {
      busy = false;
    }
  }
}
