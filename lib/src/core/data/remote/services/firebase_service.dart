// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:injectable/injectable.dart';
// import '../../local/storage.dart';

// @singleton
// class FirebaseService {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;
//   final FirebaseStorage _storage;

//   FirebaseService(this._firestore, this._auth, this._storage);

//   // Getters
//   FirebaseFirestore get firestore => _firestore;
//   FirebaseAuth get auth => _auth;
//   FirebaseStorage get storage => _storage;

//   String get uid => _auth.currentUser?.uid ?? Storage.userID ?? 'anonymous';
//   bool get isAuthenticated => _auth.currentUser != null;

//   User? get currentUser => _auth.currentUser;

//   // Collections helper
//   CollectionReference<Map<String, dynamic>> collection(String path) {
//     return _firestore.collection(path);
//   }

//   DocumentReference<Map<String, dynamic>> doc(String path) {
//     return _firestore.doc(path);
//   }

//   // User-specific collections
//   CollectionReference<Map<String, dynamic>> userCollection(String collection) {
//     return _firestore.collection('users').doc(uid).collection(collection);
//   }

//   CollectionReference<Map<String, dynamic>> publicCollection(
//     String collection,
//   ) {
//     return _firestore.collection(collection);
//   }
// }
