import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

import '../widgets/body_member.dart';

class MemeberPage extends StatefulWidget {
  const MemeberPage({Key? key}) : super(key: key);

  @override
  State<MemeberPage> createState() => _MemeberPageState();
}

class _MemeberPageState extends State<MemeberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const BodyMember(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed(AppRoutes.MEMBER_FORM);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
