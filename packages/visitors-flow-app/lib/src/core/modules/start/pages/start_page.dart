import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../config/app_routes.dart';
import '../store/start_store.dart';

class StartPage extends StatefulWidget {
  final String title;
  const StartPage({Key? key, this.title = 'StartPage'}) : super(key: key);
  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  final StartStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      bottomNavigationBar: Observer(
        builder: (context) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Gerenciamento',
                icon: Icon(Icons.app_registration),
              ),
              BottomNavigationBarItem(
                label: 'Configuração',
                icon: Icon(Icons.settings),
              ),
            ],
            currentIndex: store.currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            onTap: (index) {
              store.currentIndex = index;
              switch (index) {
                case 0:
                  Modular.to.navigate(AppRoutes.HOME);
                  break;
                case 1:
                  Modular.to.navigate(AppRoutes.MANAGEMENT);
                  break;
                case 2:
                  Modular.to.navigate(AppRoutes.CONFIG);
                  break;
                default:
                  Modular.to.navigate(AppRoutes.HOME);
              }
            },
          );
        },
      ),
    );
  }
}
