import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../config/app_routes.dart';
import '../controllers/member_controller.dart';
import '../models/member_model.dart';

class BodyMember extends StatefulWidget {
  const BodyMember({Key? key}) : super(key: key);

  @override
  State<BodyMember> createState() => _BodyMemberState();
}

class _BodyMemberState extends ModularState<BodyMember, MemberController> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await controller.getMembers();
  }

  _handleCeremonies() async {
    await controller.getMembers();
  }

  Widget getCardMember(MemberModel member) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.people,
            color: Theme.of(context).colorScheme.secondary,
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

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: controller.busy
            ? const Center(child: CircularProgressIndicator())
            : controller.members.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _handleCeremonies();
                            },
                            child: ListView.builder(
                              itemCount: controller.members.length,
                              itemBuilder: (ctx, i) => Column(
                                children: <Widget>[
                                  getCardMember(controller.members[i]),
                                  const Divider(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                      'Nenhum membro cadastrado!',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
      );
    });
  }
}
