import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/providers/form_provider.dart';
import 'package:note_app/providers/note_list_provider.dart';
import 'package:note_app/screens/note_mode_screen.dart';
import 'package:note_app/utils/colors.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Note> notesList = ref.watch(noteListProvider).notes;
    final note = notesList[index];

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(note.color),
        appBar: DetailsAppBar(note: note),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  note.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                const Text('22/08/1990 10:37 pm'),
                const SizedBox(height: 10),
                Text(
                  note.desc,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const DetailsAppBar({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = ref.watch(noteTitleProvider);
    final descController = ref.watch(noteDescProvider);

    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      title: Text(note.title),
      actions: [
        IconButton(
          onPressed: () {
            titleController.text = note.title;
            descController.text = note.desc;
            ref.read(colorProvider.notifier).state = note.color;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteModeScreen(
                    id: note.id,
                    formMode: FormMode.edit,
                  ),
                ));
          },
          icon: const Icon(
            Icons.edit,
          ),
        ),
      ],
    );
  }

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;
}
