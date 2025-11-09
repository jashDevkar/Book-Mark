import 'package:flutter/material.dart';

final kButtonDecoration = TextButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(10),
  ),
  foregroundColor: Colors.white,
  backgroundColor: Colors.blue.shade700,
);

final kBoxDecoration = BoxDecoration(
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.circular(10),
  color: const Color.fromARGB(197, 255, 255, 255),

  border: Border.all(color: Color(0xff0E1C36), width: 1),
);
