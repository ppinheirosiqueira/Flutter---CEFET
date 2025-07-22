import 'package:cloud_firestore/cloud_firestore.dart';

class FiretostoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // CREATE
  Future<void> addNote(String title, String description) {
    return notes.add({
      'title': title,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }

  // READ
  Stream<QuerySnapshot> getNotes() {
    return notes.orderBy('timestamp', descending: true).snapshots();
  }

  // UPDATE
  Future<void> updateNote(String title, String description, String docID) {
    return notes.doc(docID).update({
      'title': title,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}