import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/config/app_messages.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/ceremony/models/ceremony_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/ceremony/services/interfaces/ceremony_service_interface.dart';

import '../../../../../../../config/app_routes.dart';
import '../models/visitor_model.dart';
import '../services/interfaces/visitor_service_interfaces.dart';
import '../view-model/visitor_view_model.dart';

part 'visitor_controller.g.dart';

// ignore: library_private_types_in_public_api
class VisitorController = _VisitorControllerBase with _$VisitorController;

abstract class _VisitorControllerBase with Store {
  @observable
  VisitorModel visitor = VisitorModel();

  @observable
  List<CeremonyModel> ceremonies = [];

  @observable
  List<VisitorModel> visitors = [];

  @observable
  bool busy = false;

  @observable
  String filter = "";

  IVisitorService service;
  ICeremonyService ceremonyService;

  _VisitorControllerBase(this.service, this.ceremonyService);

  @computed
  VisitorViewModel get model => VisitorViewModel(
        id: visitor.sId,
        name: visitor.name,
        email: visitor.email,
        telephone: visitor.telephone,
        isChurchgoer: visitor.isChurchgoer,
        church: visitor.church,
        observations: visitor.observations,
        ceremonies: visitor.ceremonies,
      );

  Future<void> getVisitorsByName() async {
    try {
      busy = true;
      var result = await service.getVisitorsByName(filter);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (visitors) async {
        this.visitors = visitors;
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

  Future<void> getCeremonies() async {
    try {
      busy = true;
      var result = await ceremonyService
          .getCeremoniesOfDay(DateTime.now().toUtc().toLocal());
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (ceremonies) async {
        busy = false;
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

  Future<void> getVisitors() async {
    try {
      busy = true;
      var result = await service.getVisitors();
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (visitors) async {
        busy = false;
        this.visitors = visitors;
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

  Future<void> deleteVisitor() async {
    try {
      busy = true;
      var result = await service.deleteVisitor(model);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.EXCLUSION_MESSAGE)));
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

  Future<void> udapteVisitor() async {
    try {
      busy = true;
      var result = await service.updateVisitor(model);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
        Future.delayed(const Duration(seconds: 2), () {
          Modular.to.navigate(AppRoutes.VISITOR);
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

  Future<void> createVisitor() async {
    try {
      busy = true;
      var result = await service.createVisitor(model);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (userCreateModel) async {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.CREATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.VISITOR);
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
