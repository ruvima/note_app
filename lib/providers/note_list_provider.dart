import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/models/note_model.dart';

enum FormMode {
  edit,
  add,
}

class NoteListState {
  final List<Note> notes;
  const NoteListState({
    required this.notes,
  });

  factory NoteListState.initial() {
    return NoteListState(notes: [
      Note(
        title: '1914 translation by H. Rackham',
        id: '1',
        desc:
            '"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains."',
        color: '#edf095',
      ),
      Note(
        title:
            'Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC',
        id: '2',
        desc:
            'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.',
        color: '#f0bc92',
      ),
      Note(
        title: '1914 translation by H. Rackham',
        id: '3',
        desc:
            '"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"',
        color: '#3fe0b8',
      ),
    ]);
  }

  NoteListState copyWith({
    List<Note>? notes,
  }) {
    return NoteListState(
      notes: notes ?? this.notes,
    );
  }
}

final noteListProvider =
    StateNotifierProvider<NoteListNotifier, NoteListState>((ref) {
  return NoteListNotifier();
});

class NoteListNotifier extends StateNotifier<NoteListState> {
  NoteListNotifier() : super(NoteListState.initial());

  void addNote(String title, String desc, String color) {
    final newNote = Note(title: title, desc: desc, color: color);
    final newNotes = [...state.notes, newNote];

    state = state.copyWith(notes: newNotes);
  }

  void removeNote(Note note) {
    final newNotes = state.notes
        .where(
          (Note n) => n.id != note.id,
        )
        .toList();

    state = state.copyWith(notes: newNotes);
  }

  void editNote(String id, String title, String desc, String color) {
    final newNotes = state.notes.map((Note note) {
      if (note.id == id) {
        return Note(
          id: id,
          title: title,
          desc: desc,
          color: color,
        );
      }
      return note;
    }).toList();

    state = state.copyWith(notes: newNotes);
  }
}
