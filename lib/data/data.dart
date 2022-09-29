import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:note_app/data/get_all_notes_response/get_all_notes_response.dart';
import 'package:note_app/data/note_model/note_model.dart';
import 'package:note_app/data/url.dart';

abstract class ApiCalls {
  Future<NoteModel?> createNote(NoteModel notes);
  Future<List<NoteModel?>> getNotes();
  Future<NoteModel?> updateNotes(NoteModel notes);
  Future<void> deleteNotes(String id);
}

class NoteDB extends ApiCalls {
  final dio = Dio();
  final url = URL();
  NoteDB() {
    dio.options =
        BaseOptions(baseUrl: url.baseUrl, responseType: ResponseType.plain);
  }

  @override
  Future<NoteModel?> createNote(NoteModel notes) async {
    final result = await dio.post(url.createNote, data: notes.toJson());
    final resultAsJson = jsonDecode(result.data);

    return NoteModel.fromJson(resultAsJson as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNotes(String id) async {
    final result =
        await dio.get<GetAllNotesResponse>(url.baseUrl + url.getNote);
    (result.data == null) ? [] : result.data!.data;
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    final result = await dio.get(url.getNote);
    if (result.data != null) {
      final resultAsJson = jsonDecode(result.data);
      final getNoteResp = GetAllNotesResponse.fromJson(resultAsJson);
      return getNoteResp.data;
    } else {
      return result.data!.data;
    }
  }

  @override
  Future<NoteModel?> updateNotes(NoteModel notes) async {
    throw UnimplementedError();
  }
}
