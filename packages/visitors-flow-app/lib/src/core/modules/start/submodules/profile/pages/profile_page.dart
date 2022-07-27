import 'package:flutter/material.dart';
import '../widgets/body_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Perfil',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: const Center(child: BodyProfile()),
    );
  }
}
