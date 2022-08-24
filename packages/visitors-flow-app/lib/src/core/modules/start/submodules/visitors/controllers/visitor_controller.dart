import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/config/app_messages.dart';
import '../../../../../config/app_routes.dart';
import '../models/visitor_model.dart';
import '../services/visitor_service.dart';
import '../view-model/visitor_view_model.dart';
part 'visitor_controller.g.dart';

// ignore: library_private_types_in_public_api
class VisitorController = _VisitorControllerBase with _$VisitorController;

abstract class _VisitorControllerBase with Store {
  @observable
  VisitorModel visitor = VisitorModel();

  @observable
  List<VisitorModel> visitors = [];

  @observable
  bool busy = false;

  @observable
  String filter = "";

  VisitorService service;

  _VisitorControllerBase(this.service);

  @computed
  VisitorViewModel get model => VisitorViewModel(
        id: visitor.sId,
        name: visitor.name,
        email: visitor.email,
        telephone: visitor.telephone,
        isChurchgoer: visitor.isChurchgoer,
        church: visitor.church,
        observations: visitor.observations,
      );

  Future<void> getVisitorsByName() async {
    try {
      busy = true;
      var result = await service.getVisitorsByName(filter);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (visitors) async {
        this.visitors = visitors;
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

  Future<void> getVisitors() async {
    try {
      busy = true;
      var result = await service.getVisitors();
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (visitors) async {
        busy = false;
        this.visitors = visitors;
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

  Future<void> deleteVisitor() async {
    try {
      busy = true;
      var result = await service.deleteVisitor(model);
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

  Future<void> udapteVisitor() async {
    try {
      busy = true;
      var result = await service.updateVisitor(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
        Future.delayed(const Duration(seconds: 2), () {
          Modular.to.navigate(AppRoutes.VISITOR);
        });
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

  Future<void> createVisitor() async {
    try {
      busy = true;
      var result = await service.createVisitor(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (userCreateModel) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.CREATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.VISITOR);
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
