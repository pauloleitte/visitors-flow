import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import '../../../../../../../../shared/widgets/multi_selection_widget.dart';
import '../../../../../../../config/theme_helper.dart';
import '../../notice/models/notice_model.dart';
import '../../visitors/models/visitor_model.dart';
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
    super.initState();
    _init();
  }

  void _init() async {
    if (widget.ceremony != null) {
      controller.ceremony = widget.ceremony!;
      dateinput.text = DateFormat('dd/MM/yyyy').format(widget.ceremony!.date!);
    }
    await controller.getVisitors();
    await controller.getNotices();
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

  void _showMultiSelectVisitor() async {
    final results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect<VisitorModel>(
          items: controller.visitors,
          title: 'Visitantes',
          initialValue: controller.ceremony.visitors!,
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
            initialValue: controller.ceremony.notices!);
      },
    );

    if (results != null) {
      final result = List<NoticeModel>.from(results);
      controller.ceremony.notices = result;
      setState(() {});
    }
  }

  Widget _buildListNotices() {
    if (controller.ceremony.notices != null) {
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
              itemCount: controller.ceremony.notices!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: ListTile(
                    title: Text(
                      controller.ceremony.notices![index].name!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Modular.to.pushNamed(AppRoutes.NOTICE_FORM,
                          arguments: controller.ceremony.notices![index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Text.rich(TextSpan(children: [
          const TextSpan(text: "Clique aqui para cadastar um "),
          TextSpan(
            text: 'aviso',
            recognizer: TapGestureRecognizer()
              ..onTap = () => {Modular.to.pushNamed(AppRoutes.NOTICE_FORM)},
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ])),
      );
    }
  }

  Widget _buildListVisitors() {
    if (controller.ceremony.visitors != null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Visitantes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: _showMultiSelectVisitor,
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: controller.ceremony.visitors!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: ListTile(
                    title: Text(
                      controller.ceremony.visitors![index].name!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Modular.to.pushNamed(AppRoutes.VISITOR_FORM,
                          arguments: controller.ceremony.visitors![index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        //child: Text('Don\'t have an account? Create'),
        child: Text.rich(TextSpan(children: [
          const TextSpan(text: "Clique aqui para cadastar um "),
          TextSpan(
            text: 'visitante',
            recognizer: TapGestureRecognizer()
              ..onTap = () => {Modular.to.pushNamed(AppRoutes.VISITOR_FORM)},
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ])),
      );
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
                _buildListVisitors(),
                _buildListNotices(),
                const SizedBox(height: 20.0),
                Container(
                  decoration: ThemeHelper().buttonBoxDecoration(context),
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    onPressed: controller.busy ? null : save,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Salvar".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
