import 'package:flutter/material.dart';

class CeremonyFormPage extends StatefulWidget {
  const CeremonyFormPage({Key? key}) : super(key: key);

  @override
  State<CeremonyFormPage> createState() => _CeremonyFormPageState();
}

class _CeremonyFormPageState extends State<CeremonyFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Culto',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: Container(),
    );
  }
}
