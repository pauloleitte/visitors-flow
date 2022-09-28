import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

import '../models/member_model.dart';

class MemberItem extends StatelessWidget {
  final MemberModel member;
  const MemberItem(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child:  Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          member.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.pushNamed(AppRoutes.MEMBER_FORM, arguments: member);
        },
        subtitle: Text(
          '${member.job}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
