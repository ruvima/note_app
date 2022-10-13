import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/providers/note_list.dart';
import 'package:note_app/providers/provider.dart';

class NoteDialog extends ConsumerWidget {
  const NoteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(noteFormKeyProvider);
    final titleController = ref.watch(noteTitleProvider);
    final descController = ref.watch(noteDescProvider);

    return Dialog(
      child: Container(
        child: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else {
                      null;
                    }
                  },
                  controller: titleController,
                  keyboardType: TextInputType.text),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else {
                    null;
                  }
                },
                maxLines: 5,
                controller: descController,
                keyboardType: TextInputType.multiline,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('CANCELAR'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        ref.read(noteListProvider.notifier).addNote(
                              titleController.text.trim(),
                              descController.text.trim(),
                            );

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('ACEPTAR'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
