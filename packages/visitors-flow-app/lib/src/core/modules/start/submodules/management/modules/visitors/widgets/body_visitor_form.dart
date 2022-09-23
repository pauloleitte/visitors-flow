import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/ceremony/models/ceremony_model.dart';
import 'package:visitors_flow_app/src/shared/widgets/multi_selection_widget.dart';

import '../../../../../../../config/app_routes.dart';
import '../../../../../../../config/theme_helper.dart';
import '../controllers/visitor_controller.dart';
import '../models/visitor_model.dart';

class BodyVisitorForm extends StatefulWidget {
  final VisitorModel? visitor;
  const BodyVisitorForm({Key? key, this.visitor}) : super(key: key);

  @override
  State<BodyVisitorForm> createState() => _BodyVisitorFormState();
}

class _BodyVisitorFormState
    extends ModularState<BodyVisitorForm, VisitorController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (widget.visitor != null) {
      controller.visitor = widget.visitor!;
    }
    await controller.getCeremonies();
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.visitor.sId == null) {
        await controller.createVisitor();
      } else {
        await controller.udapteVisitor();
      }
    }
  }

  void _showMultiSelect() async {
    final results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: controller.ceremonies,
          title: 'Cultos',
        );
      },
    );

    if (results != null) {
      final result = List<CeremonyModel>.from(results);
      controller.visitor.ceremonies = result;
      setState(() {});
    }
  }

  Widget _buildListCeremony() {
    if (controller.visitor.ceremonies != null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Cultos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: _showMultiSelect,
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: controller.visitor.ceremonies!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: ListTile(
                    title: Text(
                      controller.visitor.ceremonies![index].name!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Modular.to.pushNamed(AppRoutes.CEREMONY_FORM,
                          arguments: controller.visitor.ceremonies![index]);
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
        child: Stack(
          children: [
            Center(
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
                          initialValue: controller.visitor.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Insira o nome do visitante';
                            }
                            return null;
                          },
                          decoration: ThemeHelper()
                              .textInputDecoration('Nome', 'Insira seu nome'),
                          onSaved: (value) {
                            controller.visitor.name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.email,
                          decoration: ThemeHelper().textInputDecoration(
                              'E-mail', 'Insira seu e-mail'),
                          onSaved: (value) {
                            controller.visitor.email = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.telephone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          decoration: ThemeHelper().textInputDecoration(
                              'Telefone', 'Insira seu telefone'),
                          onSaved: (value) {
                            controller.visitor.telephone = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.church,
                          decoration: ThemeHelper()
                              .textInputDecoration('Igreja', 'Insira a igreja'),
                          onSaved: (value) {
                            controller.visitor.church = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.observations,
                          minLines:
                              6, // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: ThemeHelper().textInputDecoration(
                              'Observações', 'Insira alguma observação'),
                          onSaved: (value) {
                            controller.visitor.observations = value;
                          },
                        ),
                      ),
                      _buildListCeremony(),
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
            )
          ],
        ),
      );
    });
  }
}
