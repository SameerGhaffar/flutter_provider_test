import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_test/model/task_model.dart';
import 'package:flutter_provider_test/model/user_model.dart';
import 'package:flutter_provider_test/services/auth_service.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference images =
      FirebaseFirestore.instance.collection('Images');
  final AuthService _auth = AuthService();

  // Future<UserModel?> getUserData() async {
  //   try {
  //     DocumentSnapshot documentSnapshot =
  //         await images.doc(_auth.currentUser()!.uid).get();
  //     final data = documentSnapshot.data() as Map<String, dynamic>;
  //     return UserModel.fromMap(data);
  //   } catch (e) {
  //     print("Error retrieving data: $e");
  //   }
  // }

  addImage(String url) async {
    try {
      DocumentReference doc = images.doc(_auth.currentUser()!.uid);
      UserModel userModel = UserModel(
          id: doc.id,
          email: _auth.currentUser()!.email ?? "email is null",
          imageUrl: url);
      await doc.set(userModel.toMap());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  final CollectionReference todo =
      FirebaseFirestore.instance.collection('TODO');

  updateTaskAndDate(TaskModel taskModel) {
    todo.doc(taskModel.docId).update(taskModel.toUpdateTaskAndDate());
  }

  updateTask(TaskModel taskModel) {
    todo.doc(taskModel.docId).update(taskModel.toUpdateTask());
  }

  updateDate(TaskModel taskModel) {
    todo.doc(taskModel.docId).update(taskModel.toUpdateDate());
  }

  deleteTask(String? docId) {
    try {
      if (docId != null) {
        todo.doc(docId).delete();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addTask(TaskModel taskModel) async {
    try {
      DocumentReference docId = todo.doc();
      taskModel.docId = docId.id;
      docId.set(taskModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
