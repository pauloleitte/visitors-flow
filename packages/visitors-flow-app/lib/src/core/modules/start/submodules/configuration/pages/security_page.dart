import 'package:flutter/material.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/widgets/body_security.dart';

class SecurityPage extends StatefulWidget {
  SecurityPage({Key? key}) : super(key: key);

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
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BodySecurity(),
    );
  }
}
