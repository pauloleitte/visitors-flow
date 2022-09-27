import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/widgets/body_departament.dart';

class DepartamentPage extends StatefulWidget {
  const DepartamentPage({Key? key}) : super(key: key);

  @override
  State<DepartamentPage> createState() => _DepartamentPageState();
}

class _DepartamentPageState extends State<DepartamentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const BodyDepartament(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed(AppRoutes.DEPARTAMENT_FORM);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
