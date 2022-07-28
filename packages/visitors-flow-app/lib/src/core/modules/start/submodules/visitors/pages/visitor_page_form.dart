import 'package:flutter/material.dart';
import '../models/visitor_model.dart';
import '../widgets/body_visitor_form.dart';

class VisitorPageForm extends StatefulWidget {
  final VisitorModel? visitor;
  const VisitorPageForm({Key? key, this.visitor}) : super(key: key);

  @override
  State<VisitorPageForm> createState() => _VisitorPageFormState();
}

class _VisitorPageFormState extends State<VisitorPageForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Visitante',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: BodyVisitorForm(
        visitor: widget.visitor,
      ),
    );
  }
}
