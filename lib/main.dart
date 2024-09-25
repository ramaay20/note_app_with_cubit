import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_best_practice/NoteCubit/note_cubit.dart';
import 'note_app.dart';



void main() => runApp(MaterialApp(
  home:  BlocProvider(create: (BuildContext context)=> NoteCubit(),
  child: NoteAppWithStateManagement(),
  ),
  theme: ThemeData(primarySwatch: Colors.blueGrey),
));
