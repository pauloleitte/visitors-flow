import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:visitors_flow_app/src/core/config/app_routes.dart';

import '../models/departament_model.dart';

class DepartamentDetailPage extends StatefulWidget {
  final DepartamentModel? departament;
  const DepartamentDetailPage({super.key, this.departament});

  @override
  State<DepartamentDetailPage> createState() => _DepartamentDetailPageState();
}

class _DepartamentDetailPageState extends State<DepartamentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.departament!.name!),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Modular.to.navigate(AppRoutes.DEPARTAMENT),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => {
                Modular.to.pushNamed(AppRoutes.DEPARTAMENT_FORM,
                    arguments: widget.departament)
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
                Text(widget.departament!.name!,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                Text(widget.departament!.description!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center),
                const SizedBox(height: 50.0),
                Text("Avisos",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(height: 20.0),
                widget.departament!.notices != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: widget.departament!.notices!.length,
                          itemBuilder: (context, index) {
                            final notice = widget.departament!.notices![index];
                            return Card(
                              elevation: 10,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.notifications_outlined,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                title: Text(
                                  notice.name!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: null,
                                subtitle: Text(
                                  notice.description!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text("Nenhum Aviso"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
