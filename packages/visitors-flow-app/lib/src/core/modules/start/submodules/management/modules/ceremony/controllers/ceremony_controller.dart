import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/config/app_messages.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/notice/models/notice_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/notice/services/interfaces/notice_service_interface.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/visitors/models/visitor_model.dart';

import '../../../../../../../config/app_routes.dart';
import '../../visitors/services/interfaces/visitor_service_interfaces.dart';
import '../models/ceremony_model.dart';
import '../services/interfaces/ceremony_service_interface.dart';
import '../view-models/ceremony_view_model.dart';

part 'ceremony_controller.g.dart';

// ignore: library_private_types_in_public_api
class CeremonyController = _CeremonyControllerBase with _$CeremonyController;

abstract class _CeremonyControllerBase with Store {
  @observable
  CeremonyModel ceremony = CeremonyModel();

  @observable
  List<VisitorModel> visitors = [];

  @observable
  List<NoticeModel> notices = [];

  @observable
  bool busy = false;

  final ICeremonyService service;
  final IVisitorService _visitorService;
  final INoticeService _noticeService;

  _CeremonyControllerBase(
      this.service, this._visitorService, this._noticeService);

  @observable
  List<CeremonyModel> ceremonies = [];

  @computed
  CeremonyViewModel get model => CeremonyViewModel(
      id: ceremony.sId,
      name: ceremony.name,
      date: ceremony.date,
      description: ceremony.description,
      notices: ceremony.notices,
      visitors: ceremony.visitors);

  Future<void> getNotices() async {
    try {
      busy = true;
      var result = await _noticeService.getNotices();
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (notices) async {
        busy = false;
        this.notices = notices;
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

  Future<void> getVisitors() async {
    try {
      busy = true;
      var result = await _visitorService.getVisitors();
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (visitors) async {
        busy = false;
        this.visitors = visitors;
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

  Future<void> getCeremonies() async {
    try {
      busy = true;
      var result = await service.getCeremonies();
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (ceremonies) async {
        busy = false;
        this.ceremonies = ceremonies;
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

  Future<void> deleteCeremony() async {
    try {
      busy = true;
      var result = await service.deleteCeremony(model);
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

  Future<void> updateCeremony() async {
    try {
      busy = true;
      var result = await service.updateCeremony(model);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
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

  Future<void> createCeremony() async {
    try {
      busy = true;
      var result = await service.createCeremony(model);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.CREATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.CEREMONY);
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
