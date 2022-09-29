import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import '../../../../../../../config/theme_helper.dart';
import '../controllers/departament_controller.dart';
import '../models/departament_model.dart';

class BodyDepartamentForm extends StatefulWidget {
  final DepartamentModel? departament;
  const BodyDepartamentForm({Key? key, this.departament}) : super(key: key);

  @override
  State<BodyDepartamentForm> createState() => _BodyDepartamentFormState();
}

class _BodyDepartamentFormState
    extends ModularState<BodyDepartamentForm, DepartamentController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (widget.departament != null) {
      controller.departament = widget.departament!;
    }
    await controller.getMembers();
    await controller.getNotices();
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.departament.sId == null) {
        await controller.createDepartament();
      } else {
        await controller.updateDepartament();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Form(
              key: _formKey,
              child: Column(children: [
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    initialValue: controller.departament.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper().textInputDecoration(
                        'Nome', 'Insira o nome do departamento'),
                    onSaved: (value) {
                      controller.departament.name = value;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    maxLines: 8,
                    initialValue: controller.departament.description,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Descrição é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper().textInputDecoration(
                        'Descrição', 'Insira uma descrição'),
                    onSaved: (value) {
                      controller.departament.description = value;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(context),
                    onPressed: () {
                      Modular.to.pushNamed(AppRoutes.DEPARTAMENT_MEMBERS,
                          arguments: controller.departament.members);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Ver Membros".toUpperCase(),
                        style: ThemeHelper().buttonTextStyle(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(context),
                    onPressed: () {
                      Modular.to.pushNamed(AppRoutes.DEPARTAMENT_NOTICES,
                          arguments: controller.departament.notices);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Ver Avisos".toUpperCase(),
                        style: ThemeHelper().buttonTextStyle(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(context),
                    onPressed: controller.busy ? null : save,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Salvar".toUpperCase(),
                        style: ThemeHelper().buttonTextStyle(context),
                      ),
                    ),
                  ),
                ),
              ])),
        ),
      );
    });
  }
}
