import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/member/models/member_model.dart';
import '../../../../../../../../shared/widgets/multi_selection_widget.dart';
import '../../../../../../../config/theme_helper.dart';
import '../../notice/models/notice_model.dart';
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

  void _showMultiSelectMember() async {
    final results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect<MemberModel>(
          items: controller.members,
          title: 'Membros',
          initialValue: controller.departament.members!,
        );
      },
    );

    if (results != null) {
      final result = List<MemberModel>.from(results);
      controller.departament.members = result;
      setState(() {});
    }
  }

  void _showMultiSelectNotice() async {
    final results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect<NoticeModel>(
            items: controller.notices,
            title: 'Avisos',
            initialValue: controller.departament.notices!);
      },
    );

    if (results != null) {
      final result = List<NoticeModel>.from(results);
      controller.departament.notices = result;
      setState(() {});
    }
  }

  Widget _buildListNotices() {
    if (controller.departament.notices != null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Avisos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: _showMultiSelectNotice,
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: controller.departament.notices!.length,
              itemBuilder: (context, i) {
                final model = controller.departament.notices![i];
                return Card(
                  elevation: 10,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.notifications,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    title: Text(
                      model.name!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Modular.to
                          .navigate(AppRoutes.VISITOR_FORM, arguments: model);
                    },
                    subtitle: Text(
                      '${model.description}',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
                ;
              },
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _buildListMembers() {
    if (controller.departament.members != null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Membros',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: _showMultiSelectMember,
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: controller.departament.members!.length,
              itemBuilder: (context, i) {
                final model = controller.departament.members![i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    title: Text(
                      model.name!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Modular.to
                          .pushNamed(AppRoutes.MEMBER_FORM, arguments: model);
                    },
                    subtitle: Text(
                      '${model.phone}',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Container();
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
                _buildListMembers(),
                _buildListNotices(),
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
