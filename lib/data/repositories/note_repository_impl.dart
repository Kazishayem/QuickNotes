import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknotes/data/datasources/notes_remote_data_source.dart';
import 'package:quicknotes/domain/repositories/note_repository.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  final remoteDataSource = ref.watch(notesRemoteDataSourceProvider);
  return NoteRepositoryImpl(remoteDataSource);
});

class NoteRepositoryImpl implements NoteRepository {
  NoteRepositoryImpl(this._remoteDataSource);

  final NotesRemoteDataSource _remoteDataSource;

  @override
  Future<bool> addNote(String title, String description) {
    return _remoteDataSource.addNote(title, description);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream() {
    return _remoteDataSource.getNotesStream();
  }
}
