import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/app_routes.dart';
import '../../models/user_create_model.dart';
import '../../services/user_service.dart';
import '../../view-models/signup_view_model.dart';
part 'signup_controller.g.dart';

class SignupController = _SignupControllerBase with _$SignupController;

abstract class _SignupControllerBase with Store {
  @observable
  String? name;

  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? phone;

  @observable
  bool busy = false;

  @observable
  UserCreateModel? userCreateModel;

  UserService service;

  _SignupControllerBase(this.service);

  @computed
  bool get isValid =>
      model.isValidEmail && model.isValidPassword && model.isValidName;

  @computed
  bool get isValidEmail => model.isValidEmail;

  @computed
  SignupViewModel get model => SignupViewModel(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );

  Future<void> signup() async {
    try {
      busy = true;
      var result = await service.signup(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível realizar o cadastro, por favor tente novamente')));
      }, (userCreateModel) async {
        asuka.showSnackBar(
            const SnackBar(content: Text('Cadastro realizado com sucesso!')));
        Future.delayed(Duration(seconds: 2), () {
          Modular.to.navigate(AppRoutes.AUTH_HOME);
        });
      });
    } catch (e) {
      busy = false;
      asuka.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      busy = false;
    }
  }
}