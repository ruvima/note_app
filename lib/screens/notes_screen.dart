import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/providers/form_provider.dart';
import 'package:note_app/providers/note_list_provider.dart';
import 'package:note_app/screens/note_mode_screen.dart';
import 'package:note_app/screens/detail_screen.dart';
import 'package:note_app/utils/colors.dart';

class NotesPages extends ConsumerWidget {
  const NotesPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'All Notes',
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NoteModeScreen(
                        formMode: FormMode.add,
                      ),
                    ));
                ref.invalidate(colorProvider);
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20,
            ),
            child: Column(
              children: const [
                ShowNotes(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowNotes extends ConsumerWidget {
  const ShowNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Note> notesList = ref.watch(noteListProvider).notes;

    Widget showBackground(int direction) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red[400],
        ),
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        alignment:
            direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      );
    }

    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: notesList.length,
      itemBuilder: (context, index) {
        final note = notesList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(index: index),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: HexColor(note.color),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  const Text('22/08/1990 10:37 pm'),
                  const SizedBox(height: 10),
                  Text(
                    note.desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void deleteNote(WidgetRef ref, Note note) {
    ref.read(noteListProvider.notifier).removeNote(note);
  }
}
