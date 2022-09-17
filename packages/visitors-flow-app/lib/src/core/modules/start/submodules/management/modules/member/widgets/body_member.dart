import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/shared/widgets/title_widget.dart';

import '../controllers/member_controller.dart';
import 'member_item.dart';

class BodyMember extends StatefulWidget {
  const BodyMember({Key? key}) : super(key: key);

  @override
  State<BodyMember> createState() => _BodyMemberState();
}

class _BodyMemberState extends ModularState<BodyMember, MemberController> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await controller.getMembers();
  }

  _handleCeremonies() async {
    await controller.getMembers();
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
                        buildTitle(title: 'Membros'),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              _handleCeremonies();
                            },
                            child: ListView.builder(
                              itemCount: controller.members.length,
                              itemBuilder: (ctx, i) => Column(
                                children: <Widget>[
                                  MemberItem(controller.members[i]),
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
