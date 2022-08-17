import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../config/app_messages.dart';
import '../../../../auth/models/user_model.dart';
import '../../../../auth/services/interfaces/user_service_interface.dart';
import '../../ceremony/models/ceremony_model.dart';
import '../../ceremony/services/interfaces/ceremony_service_interface.dart';
part 'home_controller.g.dart';

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

  getCeremoniesOfDay(String date) async {
    try {
      busy = true;
      var result = await _ceremonyService.getCeremoniesOfDay(date);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (ceremonies) async {
        this.ceremonies = ceremonies;
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
      }, (user) async {
        model = user;
        _userService.saveLocalDB(user);
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
