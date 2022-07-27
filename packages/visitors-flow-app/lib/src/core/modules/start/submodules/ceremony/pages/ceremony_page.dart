import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';
import '../widgets/body_ceremony.dart';

class CeremonyPage extends StatefulWidget {
  const CeremonyPage({Key? key}) : super(key: key);

  @override
  State<CeremonyPage> createState() => _CeremonyPageState();
}

class _CeremonyPageState extends State<CeremonyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Cultos',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: const BodyCeremony(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed(AppRoutes.CEREMONY_FORM);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
