import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:intl/intl.dart';
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
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.ceremony != null) {
      controller.ceremony = widget.ceremony!;
      dateinput.text = DateFormat('dd/MM/yyyy').format(widget.ceremony!.date!);
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nome é obrigatório';
                            }
                            return null;
                          },
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
                                initialDate:
                                    controller.model.date ?? DateTime.now());
                            if (pickedDate != null) {
                              setState(() {
                                dateinput.text =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                          onSaved: (value) {
                            controller.ceremony.date =
                                DateFormat('dd/MM/yyyy').parse(value!);
                          },
                        ),
                        // child: TextFormField(
                        //   initialValue: controller.ceremony.date,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Data é obrigatório';
                        //     }
                        //     return null;
                        //   },
                        //   keyboardType: TextInputType.datetime,
                        //   decoration: ThemeHelper().textInputDecoration(
                        //       'Data', 'Insira a data do culto'),
                        //   onSaved: (value) {
                        //     controller.ceremony.date = value;
                        //   },
                        // ),
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
