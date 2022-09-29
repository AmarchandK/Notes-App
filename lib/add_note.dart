// ignore_for_file: unused_field, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/data/note_model/note_model.dart';

enum ActionType {
  addNote,
  editNote,
}

class ScreenAddNote extends StatefulWidget {
  final ActionType type;
  final String? id;
  const ScreenAddNote({Key? key, required this.type, this.id})
      : super(key: key);

  @override
  State<ScreenAddNote> createState() => _ScreenAddNoteState();
}

class _ScreenAddNoteState extends State<ScreenAddNote> {
  final _titleControler = TextEditingController();
  final _contentControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type.name.toUpperCase()),
        actions: [saveButton()],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _titleControler,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Title'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _contentControler,
            maxLines: 5,
            maxLength: 100,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Content'),
          ),
        )
      ]),
    );
  }

  Widget saveButton() {
    return TextButton.icon(
        onPressed: () {
          switch (widget.type) {
            case ActionType.addNote:
              saveNote();
              break;
            case ActionType.editNote:
              break;
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: const Text(
          'Save',
          style: TextStyle(color: Colors.white),
        ));
  }

  Future<void> saveNote() async {
    final title = _titleControler.text.trim();
    final contents = _contentControler.text.trim();
    final newNote = NoteModel.initial(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        content: contents);
    await NoteDB().createNote(newNote);
    Get.back();
  }
}
