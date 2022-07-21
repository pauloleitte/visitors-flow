import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app-constants.dart';
import '../../../app-images.dart';
import '../../../app-routes.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Modular.to.navigate(AppRoutes.AUTH_HOME),
    );
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: Center(
          child: Image.asset(
            AppImages.logo,
          ),
        ),
      ),
    );
  }
}
