import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../../../config/app_routes.dart';
import '../models/visitor_model.dart';
import '../services/visitor_service.dart';
import '../view-model/visitor_view_model.dart';
part 'visitor_controller.g.dart';

class VisitorController = _VisitorControllerBase with _$VisitorController;

abstract class _VisitorControllerBase with Store {
  @observable
  VisitorModel visitor = VisitorModel();

  @observable
  List<VisitorModel> visitors = [];

  @observable
  bool busy = false;

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

  Future<void> getVisitor() async {
    try {
      busy = true;
      var result = await service.getVisitor(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível recuperar o visitante, por favor tente novamente')));
      }, (visitor) async {
        // print(visitor);
      });
    } catch (e) {
      busy = false;
      asuka.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      busy = false;
    }
  }

  Future<void> getVisitors() async {
    try {
      busy = true;
      var result = await service.getVisitors();
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível recuperar os visitantes, por favor tente novamente')));
      }, (visitors) async {
        busy = false;
        this.visitors = visitors;
      });
    } catch (e) {
      busy = false;
      asuka.showSnackBar(const SnackBar(
          content: Text(
              'Não foi possível recuperar os visitantes, por favor tente novamente')));
    } finally {
      busy = false;
    }
  }

  Future<void> deleteVisitor() async {
    try {
      busy = true;
      var result = await service.deleteVisitor(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível realizar a exclusão, por favor tente novamente')));
      }, (_) async {
        busy = false;
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

  Future<void> udapteVisitor() async {
    try {
      busy = true;
      var result = await service.updateVisitor(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possível realizar a atualização, por favor tente novamente')));
      }, (_) async {
        asuka.showSnackBar(
            const SnackBar(content: Text('Atualização realizada com sucesso')));
        Future.delayed(const Duration(seconds: 2), () {
          Modular.to.navigate(AppRoutes.VISITOR);
        });
      });
    } catch (e) {
      busy = false;
      asuka.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      busy = false;
    }
  }

  Future<void> createVisitor() async {
    try {
      busy = true;
      var result = await service.createVisitor(model);
      result.fold((l) {
        asuka.showSnackBar(const SnackBar(
            content: Text(
                'Não foi possivel realizar o cadastro, por favor tente novamente')));
      }, (userCreateModel) async {
        asuka.showSnackBar(
            const SnackBar(content: Text('Cadastro realizado com sucesso!')));
        Future.delayed(const Duration(seconds: 2), () {
          Modular.to.navigate(AppRoutes.VISITOR);
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
