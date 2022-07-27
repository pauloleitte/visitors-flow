import 'package:flutter_modular/flutter_modular.dart';
import '../profile/pages/profile_page.dart';
import 'controllers/profile_controller.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => ProfileController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ProfilePage()),
  ];
}
