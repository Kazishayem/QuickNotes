import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';

/// 🔥 Provider
final noteViewModelProvider = StateNotifierProvider<NoteViewModel, bool>((ref) {
  return NoteViewModel();
});

final notesProvider = StreamProvider<QuerySnapshot>((ref) {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return const Stream.empty();
  }

  return FirebaseFirestore.instance
      .collection('notes')
      .where('uid', isEqualTo: user.uid)
      .snapshots();
});

class NoteViewModel extends StateNotifier<bool> {
  NoteViewModel() : super(false);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> addNote(String title, String description) async {
    try {
      state = true;

      final user = _auth.currentUser;

      if (user == null) {
        state = false;
        return false;
      }

      await _firestore.collection('notes').add({
        'title': title,
        'description': description,
        'uid': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      state = false;
      return true;
    } catch (e) {
      state = false;
      return false;
    }
  }
}
