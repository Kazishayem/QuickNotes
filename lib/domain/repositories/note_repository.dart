import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NoteRepository {
  Future<bool> addNote(String title, String description);
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream();
}
