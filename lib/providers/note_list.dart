import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/models/note_model.dart';

class NoteListState {
  final List<Note> notes;
  const NoteListState({
    required this.notes,
  });

  factory NoteListState.initial() {
    return NoteListState(notes: [
      Note(
        title: 'TITULO 1',
        id: '1',
        desc: 'Nueva nota2',
        color: Colors.pink,
      ),
      Note(
        title: 'TITULO 2',
        id: '2',
        desc: 'Nueva nota3',
        color: Colors.green,
      ),
      Note(
        title: 'TITULO 3',
        id: '3',
        desc: 'Nueva nota4',
        color: Colors.grey,
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

  void addNote(String title, String desc) {
    final newNote = Note(title: title, desc: desc);
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
}
