import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../config/app_routes.dart';
import '../../../../../config/theme_helper.dart';
import '../../../../auth/models/user_model.dart';
import '../widgets/body_profile.dart';

class ProfilePage extends StatefulWidget {
  final UserModel? user;
  const ProfilePage({Key? key, this.user}) : super(key: key);

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.secondary),
          onPressed: () => Modular.to.navigate(AppRoutes.CONFIG),
        ),
      ),
      body: BodyProfile(user: widget.user),
    );
  }
}
