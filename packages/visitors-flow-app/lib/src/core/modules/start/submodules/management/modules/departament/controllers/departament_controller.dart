import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/member/models/member_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/member/services/interfaces/member_service_interface.dart';

import '../../../../../../../config/app_messages.dart';
import '../../../../../../../config/app_routes.dart';
import '../../notice/models/notice_model.dart';
import '../../notice/services/interfaces/notice_service_interface.dart';
import '../models/departament_model.dart';
import '../services/interfaces/departament_service_interface.dart';
import '../view-models/departament_view_model.dart';

part 'departament_controller.g.dart';

// ignore: library_private_types_in_public_api
class DepartamentController = _DepartamentControllerBase
    with _$DepartamentController;

abstract class _DepartamentControllerBase with Store {
  @observable
  DepartamentModel departament = DepartamentModel();

  @observable
  List<MemberModel> members = [];

  @observable
  List<NoticeModel> notices = [];

  @observable
  bool busy = false;

  final IDepartamentService service;
  final IMemberService _memberService;
  final INoticeService _noticeService;

  _DepartamentControllerBase(
      this.service, this._memberService, this._noticeService);

  @observable
  List<DepartamentModel> departaments = [];

  @computed
  DepartamentViewModel get model => DepartamentViewModel(
      id: departament.sId,
      name: departament.name,
      description: departament.description,
      notices: departament.notices,
      members: departament.members);

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

  Future<void> getMembers() async {
    try {
      busy = true;
      var result = await _memberService.getMembers();
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (members) async {
        busy = false;
        this.members = members;
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

  Future<void> getDepartaments() async {
    try {
      busy = true;
      var result = await service.getDepartaments();
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (departaments) async {
        busy = false;
        this.departaments = departaments;
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

  Future<void> deleteDepartament() async {
    try {
      busy = true;
      var result = await service.deleteDepartament(model);
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

  Future<void> updateDepartament() async {
    try {
      busy = true;
      var result = await service.updateDepartament(model);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.DEPARTAMENT);
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

  Future<void> createDepartament() async {
    try {
      busy = true;
      var result = await service.createDepartament(model);
      result.fold((l) {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        Asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.CREATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.DEPARTAMENT);
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
