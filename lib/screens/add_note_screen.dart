import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/providers/note_list_provider.dart';
import 'package:note_app/providers/form_provider.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/widgets/color_picker.dart';

class AddNoteScreen extends ConsumerWidget {
  const AddNoteScreen({
    Key? key,
    this.validator,
    this.id,
    required this.formMode,
  }) : super(key: key);
  final FormFieldValidator<String>? validator;
  final FormMode formMode;
  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(noteFormKeyProvider);
    final titleController = ref.watch(noteTitleProvider);
    final descController = ref.watch(noteDescProvider);
    final bgColor = ref.watch(colorProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(bgColor),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'Add new Note',
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const ThemeBottomSheet(),
                );
              },
              icon: const Icon(Icons.style_outlined),
            ),
            IconButton(
              onPressed: () {
                switch (formMode) {
                  case FormMode.edit:
                    if (key.currentState!.validate()) {
                      ref.watch(noteListProvider.notifier).editNote(
                            id!,
                            titleController.text.trim(),
                            descController.text.trim(),
                            bgColor,
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Note updated!!')),
                      );
                      Navigator.pop(context);
                    }
                    break;
                  case FormMode.add:
                    if (key.currentState!.validate()) {
                      ref.read(noteListProvider.notifier).addNote(
                            titleController.text.trim(),
                            descController.text.trim(),
                            bgColor,
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Note added!!')),
                      );
                      Navigator.pop(context);
                    }
                    break;
                  default:
                    break;
                }
              },
              icon: const Icon(
                Icons.check,
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
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Note title',
                        hintStyle: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w400),
                        errorStyle: TextStyle(height: 0),
                      ),
                      validator: (validator == null)
                          ? ((v) => ((v?.length ?? 0) == 0)
                              ? 'Please enter the title'
                              : null)
                          : validator,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: null,
                      controller: descController,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Note content',
                        hintStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        errorStyle: TextStyle(height: 0),
                      ),
                      validator: (validator == null)
                          ? ((v) => ((v?.length ?? 0) == 0)
                              ? 'Please enter some text'
                              : null)
                          : validator,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}



// class DetailsNotes extends ConsumerWidget {
//   const DetailsNotes({Key? key, this.validator}) : super(key: key);
//   final FormFieldValidator<String>? validator;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final key = ref.watch(noteFormKeyProvider);
//     final titleController = ref.watch(noteTitleProvider);
//     final descController = ref.watch(noteDescProvider);

//     return Form(
//       key: key,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_back),
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
//               const Text(
//                 'Add new Note',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
//               ),
//               IconButton(
//                 onPressed: () {
//                   if (key.currentState!.validate()) {
//                     ref.read(noteListProvider.notifier).addNote(
//                           titleController.text.trim(),
//                           descController.text.trim(),
//                            Colors.red,
//                         );
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Success')),
//                     );
//                     Navigator.pop(context);
//                   }
//                 },
//                 icon: const Icon(Icons.check),
//                 constraints: const BoxConstraints(),
//                 padding: EdgeInsets.zero,
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: titleController,
//             keyboardType: TextInputType.text,
//             style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               hintText: 'Note title',
//               hintStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
//               errorStyle: TextStyle(height: 0),S
//             ),
//             validator: (validator == null)S
//                 ? ((v) =>
//                     ((v?.length ?? 0) == 0) ? 'Please enter the title' : null)
//                 : validator,
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             maxLines: null,
//             controller: descController,
//             keyboardType: TextInputType.multiline,
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               hintText: 'Note content',
//               hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
//               errorStyle: TextStyle(height: 0),
//             ),
//             validator: (validator == null)
//                 ? ((v) =>
//                     ((v?.length ?? 0) == 0) ? 'Please enter some text' : null)
//                 : validator,
//           ),
//         ],
//       ),
//     );
//   }
// }
