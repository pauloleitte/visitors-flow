import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app-constants.dart';
import '../controllers/signup/signup_controller.dart';

class BodySignup extends StatefulWidget {
  BodySignup({Key? key}) : super(key: key);

  @override
  _BodySignupState createState() => _BodySignupState();
}

class _BodySignupState extends ModularState<BodySignup, SignupController> {
  final _form = GlobalKey<FormState>();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _passwordController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        controller.file = _image;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  Future<void> signup() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      controller.signup();
    }
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
        onChanged: (value) {
          controller.email = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'campo obrigatório';
          }
          if (!controller.isValidEmail) {
            return 'Informe um e-mail válido';
          }
          return null;
        },
        onSaved: (value) {
          controller.email = value;
        });
  }

  Widget buildPassword() {
    return TextFormField(
        onTap: () {
          _requestFocus(_passwordFocusNode);
        },
        obscureText: true,
        controller: _passwordController,
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
          controller.password = value;
        });
  }

  Widget buildConfirmPassword() {
    return TextFormField(
        onTap: () {
          _requestFocus(_confirmPasswordFocusNode);
        },
        obscureText: true,
        focusNode: _confirmPasswordFocusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: 'confirme a senha',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
                color: kSecondaryColor,
                fontWeight: _confirmPasswordFocusNode.hasFocus
                    ? FontWeight.bold
                    : FontWeight.normal)),
        validator: (value) {
          if (value!.isEmpty) {
            return 'campo obrigatório';
          }
          if (value.isNotEmpty) {
            if (value != _passwordController.text) {
              return 'As senhas não correspondem.';
            }
            return null;
          }
          return null;
        },
        onSaved: (value) {
          controller.confirmPassword = value;
        });
  }

  Widget buildName() {
    return TextFormField(
        onTap: () {
          _requestFocus(_nameFocusNode);
        },
        focusNode: _nameFocusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelText: 'nome',
            border: OutlineInputBorder(),
            labelStyle: TextStyle(
                color: kSecondaryColor,
                fontWeight: _nameFocusNode.hasFocus
                    ? FontWeight.bold
                    : FontWeight.normal)),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return 'campo obrigatório';
          }
          return null;
        },
        onSaved: (value) {
          controller.name = value;
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
                    buildName(),
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
                    buildConfirmPassword(),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.busy ? null : signup,
                          child: Text(
                            'Confirmar',
                            style: kTextStyleButtonAuth,
                          ),
                        )),
                  ]),
            ),
          ),
        ),
      );
    });
  }
}
