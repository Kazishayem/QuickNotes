import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:quicknotes/data/repositories/note_repository_impl.dart';
import 'package:quicknotes/domain/repositories/note_repository.dart';

final noteViewModelProvider = StateNotifierProvider<NoteViewModel, bool>((ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return NoteViewModel(repository);
});

final notesProvider = StreamProvider<QuerySnapshot>((ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return repository.getNotesStream();
});

class NoteViewModel extends StateNotifier<bool> {
  NoteViewModel(this._noteRepository) : super(false);
  final NoteRepository _noteRepository;

  Future<bool> addNote(String title, String description) async {
    try {
      state = true;
      return await _noteRepository.addNote(title, description);
    } catch (_) {
      return false;
    } finally {
      state = false;
    }
  }
}
