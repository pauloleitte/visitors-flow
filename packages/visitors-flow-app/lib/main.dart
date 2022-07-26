// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/app-module.dart';
import 'package:visitors_flow_app/src/app-widget.dart';

void main() =>
    runApp(ModularApp(module: AppModule(), child: const AppWidget()));
