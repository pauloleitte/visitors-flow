import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/app_messages.dart';
import '../../../../config/app_routes.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../../view-models/signup_view_model.dart';
part 'signup_controller.g.dart';

// ignore: library_private_types_in_public_api
class SignupController = _SignupControllerBase with _$SignupController;

abstract class _SignupControllerBase with Store {
  @observable
  UserModel model = UserModel();

  @observable
  bool busy = false;

  UserService service;

  _SignupControllerBase(this.service);

  @computed
  bool get isValid => vm.isValidEmail && vm.isValidPassword && vm.isValidName;

  @computed
  bool get isValidEmail => vm.isValidEmail;

  @computed
  SignupViewModel get vm => SignupViewModel(
        email: model.email,
        password: model.password,
        name: model.name,
        phone: model.phone,
      );

  Future<void> signup() async {
    try {
      busy = true;
      var result = await service.signup(vm);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (userCreateModel) async {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.CREATE_MESSAGE)));
        Future.delayed(const Duration(seconds: 2), () {
          Modular.to.navigate(AppRoutes.AUTH);
        });
      });
    } catch (e) {
      busy = false;
      Asuka.showSnackBar(const SnackBar(
          content: Text(
        AppMessages.ERROR_MESSAGE,
      )));
    } finally {
      busy = false;
    }
  }
}
