import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:note_app/add_note.dart';

class ScreenAllNotes extends StatefulWidget {
  const ScreenAllNotes({Key? key}) : super(key: key);

  @override
  State<ScreenAllNotes> createState() => _ScreenAllNotesState();
}

class _ScreenAllNotesState extends State<ScreenAllNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Notes'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add New'),
        onPressed: () => Get.to(
          ScreenAddNote(type: ActionType.addNote),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GridView.count(
        crossAxisSpacing: 2,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: List.generate(
            10,
            (index) => NoteItem(
                content: "Content Added",
                id: index.toString(),
                title: 'Title $index')),
      ),
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
          Get.to(ScreenAddNote(
            type: ActionType.editNote,
            id: id,
          ));
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
        ));
  }
}
