import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../config/app_routes.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isVisible = false;

  _SplashPageState() {
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        Modular.to.navigate(AppRoutes.AUTH);
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Center(
            child: Image.asset(
              'assets/images/logo_vila_yara.png',
              height: 700.0,
              width: 700.0,
            ),
          ),
        ),
      ),
    );
  }
}
