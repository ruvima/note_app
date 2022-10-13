import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Note {
  final String id;
  final String title;
  final String desc;
  // final Timestamp createAt;
  final Color color;
  Note({
    required this.title,
    String? id,
    required this.desc,
    // required this.createAt,
    this.color = Colors.blue,
  }) : id = id ?? uuid.v4();
}
