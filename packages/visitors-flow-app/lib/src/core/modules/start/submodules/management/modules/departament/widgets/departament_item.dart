import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

import '../models/departament_model.dart';

class DepartamentItem extends StatelessWidget {
  final DepartamentModel departament;

  const DepartamentItem(this.departament, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.people_alt_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          departament.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to
              .pushNamed(AppRoutes.DEPARTAMENT_FORM, arguments: departament);
        },
        subtitle: Text(departament.description!,
            style: const TextStyle(
              color: Colors.black,
            )),
      ),
    );
  }
}
