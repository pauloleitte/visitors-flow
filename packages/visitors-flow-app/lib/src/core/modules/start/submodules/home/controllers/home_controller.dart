import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/services/ceremony_service.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/services/interfaces/ceremony_service_interface.dart';

import '../../../../../config/app_messages.dart';
import '../../ceremony/models/ceremony_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  ICeremonyService _ceremonyService;
  _HomeControllerBase(this._ceremonyService);

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
        busy = false;
        this.ceremonies = ceremonies;
      });
    } catch (e) {
      busy = false;
      asuka.showSnackBar(const SnackBar(
          content: Text(
        AppMessages.ERROR_MESSAGE,
      )));
    } finally {
      busy = false;
    }
  }
}
