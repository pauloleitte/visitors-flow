import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/visitors/models/visitor_model.dart';

import '../../../../../config/theme_helper.dart';
import '../controllers/visitor_controller.dart';

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
    if (widget.visitor != null) {
      controller.visitor = widget.visitor!;
    }
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

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.visitor.name,
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
