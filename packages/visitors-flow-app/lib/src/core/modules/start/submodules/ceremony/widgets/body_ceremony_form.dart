import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../config/theme_helper.dart';
import '../controllers/ceremony_controller.dart';
import '../models/ceremony_model.dart';

class BodyCeremonyForm extends StatefulWidget {
  final CeremonyModel? ceremony;
  BodyCeremonyForm({Key? key, this.ceremony}) : super(key: key);

  @override
  State<BodyCeremonyForm> createState() => _BodyCeremonyFormState();
}

class _BodyCeremonyFormState
    extends ModularState<BodyCeremonyForm, CeremonyController> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.ceremony != null) {
      controller.ceremony = widget.ceremony!;
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
                          initialValue: controller.ceremony.name,
                          decoration: ThemeHelper().textInputDecoration(
                              'Nome', 'Insira o nome do culto'),
                          onSaved: (value) {
                            controller.ceremony.name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.ceremony.description,
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
                          initialValue: controller.ceremony.date,
                          keyboardType: TextInputType.datetime,
                          decoration: ThemeHelper().textInputDecoration(
                              'Data', 'Insira a data do culto'),
                          onSaved: (value) {
                            controller.ceremony.date = value;
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
