import 'package:flutter_modular/flutter_modular.dart';
import '../auth/services/user_service.dart';
import 'controllers/profile_controller.dart';
import 'pages/profile_page.dart';
import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => UserService(i.get())),
    Bind.factory((i) => ProfileController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage()),
    ChildRoute('/home', child: (_, args) => const HomePage()),
    ChildRoute('/profile', child: (_, args) => const ProfilePage())
  ];
}
