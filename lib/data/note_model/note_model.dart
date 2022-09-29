import 'package:json_annotation/json_annotation.dart';

class NoteModel {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? content;
  NoteModel.initial(
      {required this.id, required this.title, required this.content});
  NoteModel({this.id, this.title, this.content});

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
      };
}
