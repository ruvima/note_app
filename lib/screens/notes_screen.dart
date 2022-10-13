import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/providers/note_list.dart';
import 'package:note_app/screens/details_screen.dart';
import 'package:note_app/widgets/note_dialog.dart';

class NotesPages extends StatelessWidget {
  const NotesPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20,
            ),
            child: Column(
              children: const [
                NoteHeader(),
                SizedBox(height: 10),
                ShowNotes(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoteHeader extends StatelessWidget {
  const NoteHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: SizedBox()),
        const Text(
          'All notes',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        const Expanded(child: SizedBox()),
        Row(
          children: [
            const Icon(Icons.search),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsScreen(),
                    ));
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

class ShowNotes extends ConsumerWidget {
  const ShowNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Note> notesList = ref.watch(noteListProvider).notes;
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: notesList.length,
      itemBuilder: (context, index) {
        final note = notesList[index];
        return Card(
          color: note.color,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Are you sure?'),
                              content:
                                  const Text('Do you really want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    print(note.id);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteNote(ref, note);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  note.desc,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: const Text('22-08-1990'),
                ),
              ],
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
