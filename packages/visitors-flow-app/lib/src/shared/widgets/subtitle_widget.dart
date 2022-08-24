import 'package:flutter/material.dart';

Widget subTitle({required String title}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 24,
              color: Color(0xff0a1034),
              fontWeight: FontWeight.w200),
        ),
      ),
    ],
  );
}
