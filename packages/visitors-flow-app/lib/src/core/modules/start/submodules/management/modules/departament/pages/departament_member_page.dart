import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../member/models/member_model.dart';
import '../controllers/departament_controller.dart';

class DepartamentMemberPage extends StatefulWidget {
  final List<MemberModel> members;
  const DepartamentMemberPage({super.key, required this.members});

  @override
  State<DepartamentMemberPage> createState() => _DepartamentMemberPageState();
}

class _DepartamentMemberPageState
    extends ModularState<DepartamentMemberPage, DepartamentController> {
  Widget _getCardMember(MemberModel member) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          member.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: null,
        subtitle: Text(
          '${member.job}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildListMembers() {
    if (widget.members.isNotEmpty) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.members.length,
                itemBuilder: (ctx, i) => Column(
                  children: <Widget>[
                    _getCardMember(widget.members[i]),
                    const Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListMembers(),
      appBar: AppBar(title: const Text('Membros')),
    );
  }
}
