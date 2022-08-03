import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/ceremony/models/ceremony_model.dart';

import '../../../../../config/app_routes.dart';
import '../services/ceremony_service.dart';
import '../view-models/ceremony_view_model.dart';
part 'ceremony_controller.g.dart';

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

  Future<void> getCeremony() async {
    try {
      busy = true;
      var result = await service.getCeremony(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível recuperar o culto, por favor tente novamente')));
      }, (ceremony) async {});
    } catch (e) {
      busy = false;
      asuka.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      busy = false;
    }
  }

  Future<void> getCeremonies() async {
    try {
      busy = true;
      var result = await service.getCeremonies();
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível recuperar os cultos, por favor tente novamente')));
      }, (ceremonies) async {
        busy = false;
        this.ceremonies = ceremonies;
      });
    } catch (e) {
      busy = false;
      asuka.showSnackBar(const SnackBar(
          content: Text(
              'Não foi possível recuperar os cultos, por favor tente novamente')));
    } finally {
      busy = false;
    }
  }

  Future<void> deleteCeremony() async {
    try {
      busy = true;
      var result = await service.deleteCeremony(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível realizar a exclusão, por favor tente novamente')));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text('Exclusão realizada com sucesso')));
      });
    } catch (e) {
      busy = false;
      asuka.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      busy = false;
    }
  }

  Future<void> updateCeremony() async {
    try {
      busy = true;
      var result = await service.updateCeremony(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível realizar a atualização, por favor tente novamente')));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text('Atualização realizada com sucesso')));
        Future.delayed(const Duration(seconds: 2), () {
          Modular.to.navigate(AppRoutes.CEREMONY);
        });
      });
    } catch (e) {
      busy = false;
      asuka.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      busy = false;
    }
  }

  Future<void> createCeremony() async {
    try {
      busy = true;
      var result = await service.createCeremony(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possivel realizar o cadastro, por favor tente novamente')));
      }, (userCreateModel) async {
        asuka.showSnackBar(
            const SnackBar(content: Text('Cadastro realizado com sucesso!')));
        Future.delayed(const Duration(seconds: 2), () {
          Modular.to.navigate(AppRoutes.CEREMONY);
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
