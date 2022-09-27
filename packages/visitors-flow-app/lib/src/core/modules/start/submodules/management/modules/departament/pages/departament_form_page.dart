import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/models/departament_model.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/widgets/body_departament.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/management/modules/departament/widgets/body_departament_form.dart';

import '../controllers/departament_controller.dart';

class DepartamentFormPage extends StatefulWidget {
  final DepartamentModel? departament;
  const DepartamentFormPage({Key? key, this.departament}) : super(key: key);

  @override
  State<DepartamentFormPage> createState() => _DepartamentFormPageState();
}

class _DepartamentFormPageState
    extends ModularState<DepartamentFormPage, DepartamentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Departamento',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.arrow_back,
          //   ),
          //   onPressed: () => Modular.to.navigate(AppRoutes.CEREMONY),
          // ),
          actions: [
            ...(widget.departament?.name != null
                ? [
                    IconButton(
                      icon: Icon(Icons.delete,
                          color: Theme.of(context).primaryColor),
                      onPressed: () async {
                        controller.departament = widget.departament!;
                        await controller.deleteDepartament();
                        Modular.to.navigate(AppRoutes.DEPARTAMENT);
                      },
                    ),
                  ]
                : [])
          ]),
      body: BodyDepartamentForm(departament: widget.departament),
    );
  }
}
