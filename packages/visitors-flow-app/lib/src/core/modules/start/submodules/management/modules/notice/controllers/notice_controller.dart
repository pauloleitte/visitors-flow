import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../config/app_messages.dart';
import '../../../../../../../config/app_routes.dart';
import '../models/notice_model.dart';
import '../services/interfaces/notice_service_interface.dart';
import '../view-model/notice_view_model.dart';

part 'notice_controller.g.dart';

// ignore: library_private_types_in_public_api
class NoticeController = _NoticeControllerBase with _$NoticeController;

abstract class _NoticeControllerBase with Store {
  final INoticeService _noticeService;

  _NoticeControllerBase(this._noticeService);

  @observable
  List<NoticeModel> notices = [];

  @observable
  NoticeModel notice = NoticeModel();

  @observable
  bool busy = false;

  @computed
  NoticeViewModel get model => NoticeViewModel(
        id: notice.sId,
        name: notice.name,
        description: notice.description,
        isDone: notice.isDone,
      );

  Future<void> getNotices() async {
    try {
      busy = true;
      var result = await _noticeService.getNotices();
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (notices) async {
        busy = false;
        this.notices = notices;
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

  Future<void> deleteNotice() async {
    try {
      busy = true;
      var result = await _noticeService.deleteNotice(model);
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

  Future<void> createNotice() async {
    try {
      busy = true;
      var result = await _noticeService.createNotice(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.CREATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.NOTICE);
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

  Future<void> updateNotice() async {
    try {
      busy = true;
      var result = await _noticeService.updateNotice(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.UPDATE_MESSAGE)));
        Modular.to.navigate(AppRoutes.NOTICE);
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

  Future<void> getNotice() async {
    try {
      busy = true;
      var result = await _noticeService.getNotice(model);
      result.fold((l) {
        asuka.showSnackBar(
            const SnackBar(content: Text(AppMessages.ERROR_MESSAGE)));
      }, (notice) async {
        busy = false;
        this.notice = notice;
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
