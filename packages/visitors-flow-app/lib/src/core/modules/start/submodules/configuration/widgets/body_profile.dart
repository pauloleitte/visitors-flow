import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../config/theme_helper.dart';
import '../controllers/profile_controller.dart';

class BodyProfile extends StatefulWidget {
  BodyProfile({Key? key}) : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends ModularState<BodyProfile, ProfileController> {
  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await controller.updateUser();
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30.0),
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        initialValue: controller.model.name,
                        decoration: ThemeHelper()
                            .textInputDecoration('Nome', 'Insira seu nome'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Insira seu nome';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          controller.vm.name = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        initialValue: controller.model.email,
                        decoration: ThemeHelper()
                            .textInputDecoration("E-mail", "Insiira seu email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)) {
                            return "Insira um endereço de email válido";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          controller.vm.email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        initialValue: controller.model.phone,
                        decoration: ThemeHelper().textInputDecoration(
                            "Celular", "Insira o número do seu celular"),
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if ((val!.isEmpty) ||
                              !RegExp(r"^(\d+)*$").hasMatch(val)) {
                            return "Insira um número de celular válido";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          controller.vm.phone = value;
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
