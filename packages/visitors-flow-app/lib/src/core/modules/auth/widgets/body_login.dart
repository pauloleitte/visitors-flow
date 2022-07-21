import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app-constants.dart';
import '../../../app-images.dart';
import '../../../app-routes.dart';
import '../controllers/login/login_controller.dart';

class BodyLogin extends StatefulWidget {
  BodyLogin({Key? key}) : super(key: key);

  @override
  _BodyLoginState createState() => _BodyLoginState();
}

class _BodyLoginState extends ModularState<BodyLogin, LoginController> {
  final _form = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> login() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      controller.login();
    }
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  Widget buildEmail() {
    return TextFormField(
        onTap: () {
          _requestFocus(_emailFocusNode);
        },
        focusNode: _emailFocusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: 'e-mail',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
                color: kSecondaryColor,
                fontWeight: _emailFocusNode.hasFocus
                    ? FontWeight.bold
                    : FontWeight.normal)),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'campo obrigatório';
          }
          return null;
        },
        onSaved: (value) {
          controller.email = value!;
        });
  }

  Widget buildPassword() {
    return TextFormField(
        onTap: () {
          _requestFocus(_passwordFocusNode);
        },
        obscureText: true,
        focusNode: _passwordFocusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: 'senha',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
                color: kSecondaryColor,
                fontWeight: _passwordFocusNode.hasFocus
                    ? FontWeight.bold
                    : FontWeight.normal)),
        validator: (value) {
          if (value!.isEmpty) {
            return 'campo obrigatório';
          }
          return null;
        },
        onSaved: (value) {
          controller.password = value!;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: kPrimaryColor,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        AppImages.logo,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildEmail(),
                    SizedBox(
                      height: 20,
                    ),
                    buildPassword(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              child: Text(
                                'Não tenho uma conta',
                                style: kTextStyleLink,
                              ),
                              onTap: () =>
                                  {Modular.to.navigate(AppRoutes.AUTH_SIGNUP)},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.busy ? null : login,
                        child: Text(
                          'Entrar',
                          style: kTextStyleButtonAuth,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      );
    });
  }
}
