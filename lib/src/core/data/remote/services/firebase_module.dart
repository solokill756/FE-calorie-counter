import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @LazySingleton()
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @LazySingleton()
  FirebaseAuth get auth => FirebaseAuth.instance;

  @LazySingleton()
  FirebaseStorage get storage => FirebaseStorage.instance;
}
