import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/modules/start/submodules/member/models/member_model.dart';

import '../../../../../config/app_routes.dart';

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
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
          ),
        ),
        title: Text(
          member.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: () {
          Modular.to.navigate(AppRoutes.MEMBER_FORM, arguments: member);
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
