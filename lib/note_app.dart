import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_best_practice/widgets/note_item.dart';
import 'package:note_app_best_practice/NoteCubit/note_cubit.dart';
import 'package:note_app_best_practice/NoteCubit/note_state.dart';

class NoteAppWithStateManagement extends StatelessWidget {
  NoteAppWithStateManagement({super.key});


  @override
  Widget build(BuildContext context) {
    addNote(String title, String content)
    {
      context.read<NoteCubit>().addNote(
        title,
        content,
      );
    }
    void _showAddNoteDialog() {
      final _titleController = TextEditingController();
      final _contentController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add New Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: "Content"),
                maxLines: 4,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                addNote(_titleController.text, _contentController.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is InitialNoteState) {

            return const Center(child: Text('No Notes Available'));
          } else if (state is AddNoteState) {
            if (state.notes.isEmpty) {

              return const Center(child: Text('No Notes Available'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return NoteItem(
                  title: note.title,
                  content: note.content,
                  onDelete: () {

                    context.read<NoteCubit>().deleteNote(index);
                  },
                );
              },
            );
          } else {

            return const Center(child: Text('Something went wrong'));
          }
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
      ),
    );
  }
}
