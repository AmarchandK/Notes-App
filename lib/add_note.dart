import 'package:flutter/material.dart';

enum ActionType {
  addNote,
  editNote,
}

class ScreenAddNote extends StatefulWidget   {
  final ActionType type;
  String? id;
  ScreenAddNote({Key? key, required this.type, this.id}) : super(key: key);

  @override
  State<ScreenAddNote> createState() => _ScreenAddNoteState();
}

class _ScreenAddNoteState extends State<ScreenAddNote> {
  Widget get saveButton => TextButton.icon(
      onPressed: () {
        switch (widget.type) {
          case ActionType.addNote:
            break;
          case ActionType.editNote:
            break;
        }
      },
      icon: const Icon(Icons.save),
      label: const Text('Save'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Note'),
        actions: [saveButton],
      ),
      body: Column(children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Title'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            maxLines: 5,
            maxLength: 100,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Content'),
          ),
        )
      ]),
    );
  }
}
