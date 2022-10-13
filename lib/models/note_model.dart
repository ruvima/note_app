import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Note {
  final String id;
  final String title;
  final String desc;
  // final Timestamp createAt;
  final String color;
  Note({
    required this.title,
    String? id,
    required this.desc,
    // required this.createAt,
    required this.color,
  }) : id = id ?? uuid.v4();
}
