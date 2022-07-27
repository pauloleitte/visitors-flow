import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

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

  // BottomNavigationBar(
  //             currentIndex: 0,
  //             type: BottomNavigationBarType.fixed,
  //             backgroundColor: Theme.of(context).primaryColor,
  //             selectedItemColor: Colors.white,
  //             unselectedItemColor: Colors.white.withOpacity(.60),
  //             selectedFontSize: 14,
  //             unselectedFontSize: 14,
  //             onTap: (index) {
  //               switch (index) {
  //                 case 0:
  //                   Modular.to.navigate(AppRoutes.HOME);
  //                   break;
  //                 case 1:
  //                   Modular.to.navigate(AppRoutes.CEREMONY);
  //                   break;
  //                 case 2:
  //                   Modular.to.navigate(AppRoutes.VISITOR);
  //                   break;
  //                 case 3:
  //                   Modular.to.navigate(AppRoutes.PROFILE);
  //                   break;
  //                 default:
  //                   Modular.to.navigate(AppRoutes.HOME);
  //               }
  //             },
  //           )

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
                label: 'Cultos',
                icon: Icon(Icons.church_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Visitantes',
                icon: Icon(Icons.person_outline),
              ),
              BottomNavigationBarItem(
                label: 'Perfil',
                icon: Icon(Icons.contact_page_outlined),
              ),
            ],
            currentIndex: store.currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.white,
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
                  Modular.to.navigate(AppRoutes.CEREMONY);
                  break;
                case 2:
                  Modular.to.navigate(AppRoutes.VISITOR);
                  break;
                case 3:
                  Modular.to.navigate(AppRoutes.PROFILE);
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
