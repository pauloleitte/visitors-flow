import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../config/app_messages.dart';
import '../../../../auth/models/user_model.dart';
import '../../../../auth/services/interfaces/user_service_interface.dart';
import '../../management/modules/ceremony/models/ceremony_model.dart';
import '../../management/modules/ceremony/services/interfaces/ceremony_service_interface.dart';

part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ICeremonyService _ceremonyService;
  final IUserService _userService;

  @observable
  UserModel model = UserModel();

  _HomeControllerBase(this._ceremonyService, this._userService);

  @observable
  List<CeremonyModel> ceremonies = [];

  @observable
  bool busy = false;

  getCeremoniesOfDay(DateTime date) async {
    try {
      busy = true;
      var result = await _ceremonyService.getCeremoniesOfDay(date);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (ceremonies) async {
        this.ceremonies = ceremonies;
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
      var result = await _userService.getUser();
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (user) async {
        model = user;
        await _userService.saveLocalDB(user);
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
}
