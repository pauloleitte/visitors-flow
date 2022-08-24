import 'package:flutter/material.dart';

Widget buildTitle({required String title}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 32,
              color: Color(0xff0a1034),
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
