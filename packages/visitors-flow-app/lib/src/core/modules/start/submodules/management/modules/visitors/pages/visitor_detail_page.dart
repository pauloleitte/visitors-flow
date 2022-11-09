import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

import '../models/visitor_model.dart';

class VisitorDetailPage extends StatefulWidget {
  final VisitorModel? visitor;
  const VisitorDetailPage({super.key, this.visitor});

  @override
  State<VisitorDetailPage> createState() => _VisitorDetailPageState();
}

class _VisitorDetailPageState extends State<VisitorDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.visitor!.name!), actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => {
            Modular.to
                .pushNamed(AppRoutes.VISITOR_FORM, arguments: widget.visitor)
          },
        ),
      ]),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                Text(widget.visitor!.name!,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                Text(widget.visitor!.email!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
