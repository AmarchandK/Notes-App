// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:note_app/add_note.dart';
import 'package:note_app/data/data.dart';

import 'data/note_model/note_model.dart';

class ScreenAllNotes extends StatefulWidget {
  ScreenAllNotes({Key? key}) : super(key: key);
  List<NoteModel> noteList = [];
  @override
  State<ScreenAllNotes> createState() => _ScreenAllNotesState();
}

class _ScreenAllNotesState extends State<ScreenAllNotes> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final _noteList = await NoteDB().getNotes();
      widget.noteList.clear();
      setState(() {
        widget.noteList.addAll(_noteList.reversed);
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Notes'),
      ),
      body: GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: List.generate(widget.noteList.length, (index) {
          final note = widget.noteList[index];
          return NoteItem(
              content: note.content.toString(),
              id: note.id.toString(),
              title: note.title.toString());
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add New'),
        onPressed: () => Get.to(
          () => const ScreenAddNote(type: ActionType.addNote),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  const NoteItem(
      {Key? key, required this.content, required this.id, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ScreenAddNote(
            type: ActionType.editNote,
            id: id,
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Center(child: Text(title))),
                const IconButton(
                    onPressed: null, icon: Icon(Icons.delete_outline_sharp))
              ],
            ),
            Text(
              content,
              maxLines: 4,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }
}
