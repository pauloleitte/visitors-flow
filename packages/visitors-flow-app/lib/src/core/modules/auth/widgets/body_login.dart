import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../config/theme_helper.dart';
import '../controllers/login/login_controller.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BodyLoginState createState() => _BodyLoginState();
}

class _BodyLoginState extends ModularState<BodyLogin, LoginController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      controller.login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                child: Image.asset('assets/images/logo_vila_yara.png',
                    height: MediaQuery.of(context).size.height / 2),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Email', 'Insira seu email'),
                                  onSaved: (value) {
                                    controller.email = value;
                                  },
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Senha', 'Insira sua senha'),
                                  onSaved: (value) {
                                    controller.password = value;
                                  },
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(context),
                                  onPressed: controller.busy ? null : login,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      'Entrar'.toUpperCase(),
                                      style: ThemeHelper().buttonTextStyle(context)
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   margin:
                              //       const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              //   //child: Text('Don\'t have an account? Create'),
                              //   child: Text.rich(TextSpan(children: [
                              //     const TextSpan(
                              //         text: "Não possui uma conta? "),
                              //     TextSpan(
                              //       text: 'Criar',
                              //       recognizer: TapGestureRecognizer()
                              //         ..onTap = () => {
                              //               Modular.to.pushNamed(
                              //                   AppRoutes.AUTH_SIGNUP)
                              //             },
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           color: Theme.of(context).primaryColor),
                              //     ),
                              //   ])),
                              // ),
                            ],
                          )),
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
