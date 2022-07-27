import 'package:flutter/material.dart';

class VisitorPage extends StatefulWidget {
  VisitorPage({Key? key}) : super(key: key);

  @override
  State<VisitorPage> createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Visitantes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: const Center(
        child: Text('Visitor Page'),
      ),
    );
  }
}
