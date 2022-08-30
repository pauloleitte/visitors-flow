import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/models/member_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/view-model/member_view_model.dart';

import '../../../../../config/app_messages.dart';
import '../../../../../config/app_routes.dart';
import '../services/interfaces/member_service_interface.dart';
part 'member_controller.g.dart';

class MemberController = _MemberControllerBase with _$MemberController;

abstract class _MemberControllerBase with Store {
  final IMemberService _service;
  _MemberControllerBase(this._service);

  @observable
  bool busy = false;

  @observable
  MemberModel member = MemberModel();

  @observable
  List<MemberModel> members = [];

  @computed
  MemberViewModel get model => MemberViewModel(
      sId: member.sId,
      name: member.name,
      address: member.address,
      phone: member.phone,
      email: member.email,
      birthday: member.birthday,
      job: member.job);

  Future<void> getMembers() async {
    try {
      busy = true;
      var result = await _service.getMembers();
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (members) async {
        busy = false;
        this.members = members;
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

  Future<void> deleteMembers() async {
    try {
      busy = true;
      var result = await _service.deleteMember(model);
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

  Future<void> updateMember() async {
    try {
      busy = true;
      var result = await _service.updateMember(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.MEMBER);
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

  Future<void> createMember() async {
    try {
      busy = true;
      var result = await _service.createMember(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.CREATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.MEMBER);
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
