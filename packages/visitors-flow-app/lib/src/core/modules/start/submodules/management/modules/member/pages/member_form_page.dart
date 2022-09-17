import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../config/app_routes.dart';
import '../controllers/member_controller.dart';
import '../models/member_model.dart';
import '../widgets/body_member_form.dart';

class MemberFormPage extends StatefulWidget {
  final MemberModel? member;
  const MemberFormPage({Key? key, this.member}) : super(key: key);

  @override
  State<MemberFormPage> createState() => _MemberFormPageState();
}

class _MemberFormPageState
    extends ModularState<MemberFormPage, MemberController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Membro',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.MEMBER),
          ),
          actions: [
            ...(widget.member?.name != null
                ? [
                    IconButton(
                      icon: Icon(Icons.delete,
                          color: Theme.of(context).primaryColor),
                      onPressed: () async {
                        controller.member = widget.member!;
                        await controller.deleteMembers();
                        Modular.to.navigate(AppRoutes.MEMBER);
                      },
                    ),
                  ]
                : [])
          ]),
      body: BodyMemberForm(member: widget.member),
    );
  }
}
