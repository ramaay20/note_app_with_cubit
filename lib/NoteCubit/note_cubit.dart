import 'package:bloc/bloc.dart';
import 'package:note_app_best_practice/NoteCubit/note_state.dart';

import '../models/note_model.dart';

class NoteCubit extends Cubit<NoteState>
{
   NoteCubit():super(InitialNoteState());

   void addNote(String title, String content) {
      final note = Note(
         title: title,
         content: content,
         createdAt: DateTime.now(),
      );

      if (state is AddNoteState) {
         final currentState = state as AddNoteState;
         final updatedNotes = List<Note>.from(currentState.notes)..add(note);

         emit(AddNoteState(updatedNotes));
      } else {

         emit(AddNoteState([note]));
      }
   }

   void deleteNote(int index) {
      if (state is AddNoteState) {
         final currentState = state as AddNoteState;
         final List<Note> updatedNotes = List<Note>.from(currentState.notes)..removeAt(index);

         emit(AddNoteState(updatedNotes));

         print("Note deleted successfully");
      } else {
         print("No notes to delete");
      }
   }


}