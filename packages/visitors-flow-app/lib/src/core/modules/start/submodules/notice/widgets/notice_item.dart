import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../config/app_routes.dart';
import '../models/notice_model.dart';

class NoticeItem extends StatelessWidget {
  final NoticeModel notice;
  const NoticeItem(this.notice, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.church,
            color: Colors.white,
          ),
        ),
        title: Text(
          notice.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.navigate(AppRoutes.NOTICE_FORM, arguments: notice);
        },
        subtitle: Text(
          '${notice.description}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}