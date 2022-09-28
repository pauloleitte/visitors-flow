import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

class BodyManagement extends StatefulWidget {
  const BodyManagement({super.key});

  @override
  State<BodyManagement> createState() => _BodyManagementState();
}

class _BodyManagementState extends State<BodyManagement> {
  Widget getCardItem(String name, Icon icon, String route) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Theme.of(context).primaryColor,
              child: icon,
            ),
          ),
        ),
      ),
      onTap: () => {Modular.to.pushNamed(route)},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            getCardItem(
                'Membros',
                Icon(
                  Icons.contact_page_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                AppRoutes.MEMBER),
            getCardItem(
                'Cultos',
                Icon(
                  Icons.church_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                AppRoutes.CEREMONY),
            getCardItem(
                'Visitantes',
                Icon(
                  Icons.person_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                AppRoutes.VISITOR),
            getCardItem(
                'Avisos',
                Icon(
                  Icons.notifications_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                AppRoutes.NOTICE),
            getCardItem(
                'Departamentos',
                Icon(
                  Icons.people_alt_outlined,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                AppRoutes.DEPARTAMENT),
          ],
        ),
      ),
    );
  }
}
