
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';

/// 🔥 Provider
final noteViewModelProvider = StateNotifierProvider<NoteViewModel, bool>((ref) {
  return NoteViewModel();
});

/// 🔥 Stream Provider (for Notes List)
final notesProvider = StreamProvider<QuerySnapshot>((ref) {
  final user = FirebaseAuth.instance.currentUser;

  return FirebaseFirestore.instance
      .collection('notes')
      .where('uid', isEqualTo: user?.uid) // 🔥 only current user notes
      // .orderBy('createdAt', descending: true)
      .snapshots();
});

/// 🔥 ViewModel
class NoteViewModel extends StateNotifier<bool> {
  NoteViewModel() : super(false);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔥 ADD NOTE
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
        'createdAt': FieldValue.serverTimestamp(), // 🔥 better
      });

      state = false;
      return true;
    } catch (e) {
      state = false;
      return false;
    }
  }

  /// 🔥 DELETE NOTE (Bonus 😏)
  Future<void> deleteNote(String docId) async {
    await _firestore.collection('notes').doc(docId).delete();
  }
}
