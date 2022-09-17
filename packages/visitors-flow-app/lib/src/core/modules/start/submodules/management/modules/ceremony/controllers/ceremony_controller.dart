import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/config/app_messages.dart';

import '../../../../../../../config/app_routes.dart';
import '../models/ceremony_model.dart';
import '../services/ceremony_service.dart';
import '../view-models/ceremony_view_model.dart';

part 'ceremony_controller.g.dart';

// ignore: library_private_types_in_public_api
class CeremonyController = _CeremonyControllerBase with _$CeremonyController;

abstract class _CeremonyControllerBase with Store {
  @observable
  CeremonyModel ceremony = CeremonyModel();

  @observable
  bool busy = false;

  CeremonyService service;

  _CeremonyControllerBase(this.service);

  @observable
  List<CeremonyModel> ceremonies = [];

  @computed
  CeremonyViewModel get model => CeremonyViewModel(
        id: ceremony.sId,
        name: ceremony.name,
        date: ceremony.date,
        description: ceremony.description,
      );

  Future<void> getCeremonies() async {
    try {
      busy = true;
      var result = await service.getCeremonies();
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

  Future<void> deleteCeremony() async {
    try {
      busy = true;
      var result = await service.deleteCeremony(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.EXCLUSION_MESSAGE)));
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

  Future<void> updateCeremony() async {
    try {
      busy = true;
      var result = await service.updateCeremony(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.CEREMONY);
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

  Future<void> createCeremony() async {
    try {
      busy = true;
      var result = await service.createCeremony(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.CREATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.CEREMONY);
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
