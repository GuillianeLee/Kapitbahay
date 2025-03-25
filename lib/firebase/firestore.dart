import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailPassword(String email,
      String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailPassword(String email, String password,
      String name) async {
    try {
      // creates a new use for auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // if succesful, add data to firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': '',
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> addTask(String category) async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Generate a new document ID
      DocumentReference taskRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc();

      await taskRef.set({
        'category': category,
        'timestamp': FieldValue.serverTimestamp(),
      });

      return taskRef.id;
    } else {
      throw Exception("No user signed in");
    }
  }

  // Function to update the task with additional details
  Future<void> updateTask(String taskId, Map<String, dynamic> taskData) async {
    User? user = _auth.currentUser;
    if (user != null) {
      print("Updating Task ID: $taskId");
      print("Task Data: $taskData");

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .doc(taskId)
          .set(taskData, SetOptions(merge: true));
    } else {
      throw Exception("No user signed in");
    }
  }
}



