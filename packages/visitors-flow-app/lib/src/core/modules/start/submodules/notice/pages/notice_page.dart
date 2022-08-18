import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/notice/widgets/body_ceremony.dart';

import '../../../../../config/app_routes.dart';

class NoticePage extends StatefulWidget {
  NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Avisos',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: BodyNotice(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.navigate(AppRoutes.NOTICE_FORM);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
