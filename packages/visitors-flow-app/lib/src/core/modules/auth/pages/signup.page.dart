import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../config/app_routes.dart';
import '../widgets/body_signup.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Crie sua conta',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () => Modular.to.navigate(AppRoutes.AUTH),
            )),
        body: BodySignup());
  }
}
