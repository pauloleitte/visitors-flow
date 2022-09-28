import 'package:flutter/material.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/home/widgets/body_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      body: const BodyHome(),
    );
  }
}
