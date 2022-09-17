import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({super.key});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  Widget getCardItem(String name, Icon icon, String route) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(name),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).primaryColor,
            child: icon,
          ),
        ),
      ),
      onTap: () => {Modular.to.pushNamed(route)},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GridView.extent(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      maxCrossAxisExtent: 200.0,
      children: <Widget>[
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
    )));
  }
}
