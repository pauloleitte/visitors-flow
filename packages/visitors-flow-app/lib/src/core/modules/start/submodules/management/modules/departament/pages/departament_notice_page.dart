import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../notice/models/notice_model.dart';
import '../controllers/departament_controller.dart';

class DepartamentNoticePage extends StatefulWidget {
  final List<NoticeModel> notices;
  const DepartamentNoticePage({super.key, required this.notices});

  @override
  State<DepartamentNoticePage> createState() => _DepartamentNoticePageState();
}

class _DepartamentNoticePageState
    extends ModularState<DepartamentNoticePage, DepartamentController> {
  Widget _getCardNotice(NoticeModel notice) {
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
          notice.name!,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: null,
        subtitle: Text(
          '${notice.description}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildListNotices() {
    if (widget.notices.isNotEmpty) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.notices.length,
                itemBuilder: (ctx, i) => Column(
                  children: <Widget>[
                    _getCardNotice(widget.notices[i]),
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
      body: _buildListNotices(),
      appBar: AppBar(
        title: const Text('Avisos'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
    );
  }
}
