import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/providers/note_list.dart';
import 'package:note_app/providers/form_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow[100],
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20,
          ),
          child: DetailsNotes(),
        ),
      ),
    );
  }
}

class DetailsNotes extends ConsumerWidget {
  const DetailsNotes({Key? key, this.validator}) : super(key: key);
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(noteFormKeyProvider);
    final titleController = ref.watch(noteTitleProvider);
    final descController = ref.watch(noteDescProvider);

    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Text(
                'Add new Note',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              IconButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    ref.read(noteListProvider.notifier).addNote(
                          titleController.text.trim(),
                          descController.text.trim(),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Success')),
                    );
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.check),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: titleController,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Note title',
              hintStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              errorStyle: TextStyle(height: 0),
            ),
            validator: (validator == null)
                ? ((v) =>
                    ((v?.length ?? 0) == 0) ? 'Please enter the title' : null)
                : validator,
          ),
          TextFormField(
            maxLines: null,
            controller: descController,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Note content',
              hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              errorStyle: TextStyle(height: 0),
            ),
            validator: (validator == null)
                ? ((v) =>
                    ((v?.length ?? 0) == 0) ? 'Please enter some text' : null)
                : validator,
          ),
        ],
      ),
    );
  }
}
