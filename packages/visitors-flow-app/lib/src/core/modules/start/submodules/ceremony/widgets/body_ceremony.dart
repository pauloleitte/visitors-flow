import 'package:flutter/material.dart';

import '../models/ceremony_model.dart';
import 'ceremony_item.dart';

class BodyCeremony extends StatefulWidget {
  const BodyCeremony({Key? key}) : super(key: key);

  @override
  State<BodyCeremony> createState() => _BodyCeremonyState();
}

class _BodyCeremonyState extends State<BodyCeremony> {
  @override
  Widget build(BuildContext context) {
    var ceremonies = [];
    ceremonies.add(CeremonyModel(
        date: "21/11/1993",
        description: "bla bla bla bla",
        name: "Culto da Familia",
        sId: "1"));
    ceremonies.add(CeremonyModel(
        date: "21/11/1993",
        description: "bla bla bla bla",
        name: "Culto da Familia",
        sId: "1"));
    ceremonies.add(CeremonyModel(
        date: "21/11/1993",
        description: "bla bla bla bla",
        name: "Culto da Familia",
        sId: "1"));
    ceremonies.add(CeremonyModel(
        date: "21/11/1993",
        description: "bla bla bla bla",
        name: "Culto da Familia",
        sId: "1"));
    ceremonies.add(CeremonyModel(
        date: "21/11/1993",
        description: "bla bla bla bla",
        name: "Culto da Familia",
        sId: "1"));

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(15, 25, 15, 25),
          child: ListView.builder(
            itemCount: ceremonies.length,
            itemBuilder: (ctx, i) => Column(
              children: <Widget>[
                CeremonyItem(ceremonies[i]),
                const Divider(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
