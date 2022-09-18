import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import 'package:visitors_flow_app/src/shared/widgets/title_widget.dart';

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
            title: Text(name),
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
            buildTitle(title: 'Gerenciamento'),
            const SizedBox(
              height: 10,
            ),
            getCardItem(
                'Membros',
                const Icon(
                  Icons.contact_page_outlined,
                  color: Colors.white,
                ),
                AppRoutes.MEMBER),
            getCardItem(
                'Cultos',
                const Icon(
                  Icons.church_outlined,
                  color: Colors.white,
                ),
                AppRoutes.CEREMONY),
            getCardItem(
                'Visitantes',
                const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                AppRoutes.VISITOR),
            getCardItem(
                'Avisos',
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                AppRoutes.NOTICE),
          ],
        ),
      ),
    );
  }
}
