import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_details/models/task_model.dart';

import 'package:evently_details/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseFunctions {

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (taskModel, options) {
        return taskModel.toJson();
      },
    );
  }

  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (taskModel, options) {
        return taskModel.toJson();
      },
    );
  }

  static Future<void> createUserDB(UserModel user) {
    var collection = getUsersCollection();
    var doc = collection.doc(user.id);
    return doc.set(user);
  }

  static Future<void> createTask(TaskModel task) {
    var collection = getTasksCollection();
    var doc = collection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<void> updateTask(TaskModel task) async {
    var collection = getTasksCollection();
    return await collection.doc(task.id).update(task.toJson());
  }

  static Future<void> deleteTask(TaskModel task) {
    var collection = getTasksCollection();
    return collection.doc(task.id).delete();
  }

  static Stream<QuerySnapshot<TaskModel>> getStreamTasks({String? category}) {
    var collection = getTasksCollection();
    if (category != null) {
      return collection.where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('category', isEqualTo: category).snapshots();
    }
    return collection.where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
  }

  static Stream<QuerySnapshot<TaskModel>> getFavoriteTasks() {
    var collection = getTasksCollection();
    return collection.where('isFavorite', isEqualTo: true).snapshots();
  }

  static Future<QuerySnapshot<TaskModel>> getTasks() {
    var collection = getTasksCollection();
    return collection.get();
  }

  static Future<DocumentSnapshot<TaskModel>> getTask(TaskModel task) {
    var collection = getTasksCollection();
    return collection.doc(task.id).get();
  }

  static Future<UserModel?> getUser() async {
    var collection = getUsersCollection();
    var doc = await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return doc.data();
  }

  static Future<void> createUser(
    String name,
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      // save user data to firestore
      createUserDB(
        UserModel(
          id: credential.user!.uid,
          email: emailAddress,
          name: name,
          createAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<UserCredential?> login(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future<void> resetPassword(String emailAddress) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      }
    }
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
