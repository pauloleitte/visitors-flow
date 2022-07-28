import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../config/theme_helper.dart';
import '../controllers/signup/signup_controller.dart';

class BodySignup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodySignupState();
  }
}

class _BodySignupState extends ModularState<BodySignup, SignupController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      controller.signup();
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
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          const SizedBox(height: 30.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                  'Nome', 'Insira seu nome'),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Insira seu nome';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                controller.name = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              decoration: ThemeHelper().textInputDecoration(
                                  "E-mail", "Insiira seu email"),
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
                                controller.email = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
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
                                controller.phone = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Senha", "Insira uma senha"),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Insira uma senha";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                controller.password = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              onPressed: controller.busy ? null : signup,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Cadastrar".toUpperCase(),
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
            ),
          ],
        ),
      );
    });
  }
}
