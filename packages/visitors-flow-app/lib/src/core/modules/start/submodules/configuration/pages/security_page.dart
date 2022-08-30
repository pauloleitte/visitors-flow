import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../config/app_routes.dart';
import '../../../../auth/models/user_model.dart';
import '../widgets/body_security.dart';

class SecurityPage extends StatefulWidget {
  final UserModel? user;
  const SecurityPage({Key? key, this.user}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Segurança',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.secondary),
          onPressed: () => Modular.to.navigate(AppRoutes.CONFIG),
        ),
      ),
      body: BodySecurity(user: widget.user),
    );
  }
}
