import 'package:flutter/material.dart';
import 'package:visitors_flow_app/src/core/config/theme_helper.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/configuration/widgets/body_profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Meu Perfil',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actionsIconTheme: ThemeHelper().iconThemeData()),
      //actions logout),,
      body: BodyProfile(),
    );
  }
}
