import '../models/note_model.dart';

abstract class NoteState{}

class InitialNoteState extends NoteState {}

class AddNoteState extends NoteState
{
  final List<Note> notes;
  AddNoteState(this.notes);
}


