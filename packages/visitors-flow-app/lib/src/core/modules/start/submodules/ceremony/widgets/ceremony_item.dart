import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../config/app_routes.dart';
import '../models/ceremony_model.dart';

class CeremonyItem extends StatelessWidget {
  final CeremonyModel ceremony;

  const CeremonyItem(this.ceremony, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.church,
            color: Colors.white,
          ),
        ),
        title: Text(
          ceremony.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.navigate(AppRoutes.CEREMONY_FORM, arguments: ceremony);
        },
        subtitle: Text(
          '${ceremony.description}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
