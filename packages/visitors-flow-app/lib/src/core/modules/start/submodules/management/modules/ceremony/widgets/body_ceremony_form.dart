import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/visitors/models/visitor_model.dart';
import 'package:visitors_flow_app/src/shared/utils/mutiselect-params.dart';

import '../../../../../../../config/theme_helper.dart';
import '../../notice/models/notice_model.dart';
import '../controllers/ceremony_controller.dart';
import '../models/ceremony_model.dart';

class BodyCeremonyForm extends StatefulWidget {
  final CeremonyModel? ceremony;
  const BodyCeremonyForm({Key? key, this.ceremony}) : super(key: key);

  @override
  State<BodyCeremonyForm> createState() => _BodyCeremonyFormState();
}

class _BodyCeremonyFormState
    extends ModularState<BodyCeremonyForm, CeremonyController> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    if (widget.ceremony != null) {
      controller.ceremony = widget.ceremony!;
      dateinput.text = DateFormat('dd/MM/yyyy').format(widget.ceremony!.date!);
    }
    await controller.getVisitors();
    await controller.getNotices();
  }

  void _showMultiSelectVisitor() async {
    final data = MultiSelectParams<VisitorModel>(
        initialValue: controller.ceremony.visitors ?? [],
        items: controller.visitors,
        title: "Avisos");
    final results =
        await Modular.to.pushNamed(AppRoutes.CEREMONY_VISITOR, arguments: data);
    if (results != null) {
      final result = List<VisitorModel>.from(results as Iterable<dynamic>);
      controller.ceremony.visitors = result;
      setState(() {});
    }
  }

  void _showMultiSelectNotice() async {
    final data = MultiSelectParams<NoticeModel>(
        initialValue: controller.ceremony.notices ?? [],
        items: controller.notices,
        title: "Avisos");
    final results =
        await Modular.to.pushNamed(AppRoutes.CEREMONY_NOTICE, arguments: data);
    if (results != null) {
      final result = List<NoticeModel>.from(results as Iterable<dynamic>);
      controller.ceremony.notices = result;
      setState(() {});
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.ceremony.sId == null) {
        await controller.createCeremony();
      } else {
        await controller.updateCeremony();
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
                    initialValue: controller.ceremony.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nome é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper()
                        .textInputDecoration('Nome', 'Insira o nome do culto'),
                    onSaved: (value) {
                      controller.ceremony.name = value;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    maxLines: 8,
                    initialValue: controller.ceremony.description,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Descrição é obrigatório';
                      }
                      return null;
                    },
                    decoration: ThemeHelper().textInputDecoration(
                        'Descrição', 'Insira uma descrição'),
                    onSaved: (value) {
                      controller.ceremony.description = value;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Data é obrigatório';
                      }
                      return null;
                    },
                    controller:
                        dateinput, //editing controller of this TextField
                    decoration: ThemeHelper()
                        .textInputDecoration('Data', 'Insira uma data'),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          initialDate: controller.model.date ?? DateTime.now());
                      if (pickedDate != null) {
                        setState(() {
                          dateinput.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        });
                      }
                    },
                    onSaved: (value) {
                      controller.ceremony.date =
                          DateFormat('dd/MM/yyyy').parse(value!);
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: GestureDetector(
                        onTap: _showMultiSelectNotice,
                        child: Card(
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                Text(
                                  "Avisos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: GestureDetector(
                        onTap: _showMultiSelectVisitor,
                        child: Card(
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                Text(
                                  "Visitantes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
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
