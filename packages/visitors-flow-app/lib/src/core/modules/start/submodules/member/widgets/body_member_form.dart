import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../../config/theme_helper.dart';
import '../controllers/member_controller.dart';
import '../models/member_model.dart';

class BodyMemberForm extends StatefulWidget {
  final MemberModel? member;
  const BodyMemberForm({Key? key, this.member}) : super(key: key);

  @override
  State<BodyMemberForm> createState() => _BodyMemberFormState();
}

class _BodyMemberFormState
    extends ModularState<BodyMemberForm, MemberController> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      controller.member = widget.member!;
      dateinput.text =
          DateFormat('dd/MM/yyyy').format(widget.member!.birthday!);
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (controller.member.sId == null) {
        await controller.createMember();
      } else {
        await controller.updateMember();
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
                          initialValue: controller.member.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nome é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Nome', 'Insira o nome do membro'),
                          onSaved: (value) {
                            controller.member.name = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.member.job,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Cargo é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper()
                              .textInputDecoration('Cargo', 'Insira um cargo'),
                          onSaved: (value) {
                            controller.member.job = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.member.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Telefone é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Telefone', 'Insira um telefone'),
                          onSaved: (value) {
                            controller.member.phone = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.member.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'E-mail é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'E-mail', 'Insira um e-mail'),
                          onSaved: (value) {
                            controller.member.email = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextFormField(
                          initialValue: controller.member.address,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Endereço é obrigatório';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              'Endereço', 'Insira um endereço'),
                          onSaved: (value) {
                            controller.member.address = value;
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
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                                initialDate: controller.member.birthday ??
                                    DateTime.now());
                            if (pickedDate != null) {
                              setState(() {
                                dateinput.text =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                              });
                            }
                          },
                          onSaved: (value) {
                            controller.member.birthday =
                                DateFormat('dd/MM/yyyy').parse(value!);
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
