import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/visitors/models/visitor_model.dart';

import '../../../../../../../../shared/widgets/multi_selection_widget.dart';
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

  Widget _getCardVisitor(VisitorModel member) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(
          member.name!,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        onTap: null,
      ),
    );
  }

  Widget _getCardNotice(NoticeModel notice) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(
          notice.name!,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        onTap: null,
      ),
    );
  }

  Widget _buildListVisitors() {
    final visitors = controller.ceremony.visitors;
    if (visitors != null) {
      return Column(
        children: [
          InkWell(
              onTap: _showMultiSelectVisitor,
              child: const Text('Vincular visitantes +')),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: visitors.length,
              itemBuilder: (ctx, i) => Column(
                children: <Widget>[
                  _getCardVisitor(visitors[i]),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return InkWell(
          onTap: _showMultiSelectVisitor,
          child: const Text('Vincular visitantes +'));
    }
  }

  Widget _buildListNotices() {
    final notices = controller.ceremony.notices;
    if (notices != null) {
      return Column(
        children: [
          InkWell(
              onTap: _showMultiSelectNotice,
              child: const Text('Vincular avisos +')),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notices.length,
              itemBuilder: (ctx, i) => Column(
                children: <Widget>[
                  _getCardNotice(notices[i]),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return InkWell(
          onTap: _showMultiSelectNotice,
          child: const Text('Vincular avisos +'));
    }
  }

  void _showMultiSelectVisitor() async {
    final results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect<VisitorModel>(
          items: controller.visitors,
          title: 'Visitantes',
          initialValue: controller.ceremony.visitors ?? [],
        );
      },
    );

    if (results != null) {
      final result = List<VisitorModel>.from(results);
      controller.ceremony.visitors = result;
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
          initialValue: controller.ceremony.notices ?? [],
        );
      },
    );

    if (results != null) {
      final result = List<NoticeModel>.from(results);
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
                const SizedBox(height: 20.0),
                SizedBox(height: 150, child: _buildListVisitors()),
                const SizedBox(height: 20.0),
                SizedBox(height: 150, child: _buildListNotices()),
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
