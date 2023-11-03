import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/task_model.dart';
import 'package:flutter_provider_test/services/dialog_service.dart';
import 'package:flutter_provider_test/services/firestore_service.dart';

class TodoViewModel with ChangeNotifier {
  final DialogService dialogService = DialogService();
  final FirebaseService firebaseService = FirebaseService();

  TimeOfDay? time;
  String? selectedTime;
  TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<TaskModel> taskList = [];
  StreamSubscription<QuerySnapshot<Object?>>? stream;

  void getTaskList() {
    stream = firebaseService.todo.snapshots().listen((snapshot) {
      taskList.clear();
      taskList = List.generate(
          snapshot.size,
          (index) => TaskModel.fromMap(
              snapshot.docs[index] as DocumentSnapshot<Map<String, dynamic>>));
      notifyListeners();
    });
  }

  void disposeStream() {
    stream?.cancel();
  }

  TaskModel getTaskData(int index) {
    return taskList[index];
  }

  void onclickFAB(BuildContext context) {
    dialogService.showAddDialog(context);
  }

  void deleteTask(index) {
    firebaseService.deleteTask(getTaskData(index).docId);
  }

  void editTask(BuildContext context, int index, bool isEdit) {
    dialogService.showAddDialog(context,
        isEdit: isEdit, taskModel: getTaskData(index));
  }

  void timePicker(BuildContext context) async {
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      if (context.mounted) {
        selectedTime = time!.format(context).toString();
        notifyListeners();
      }
    }
  }

  void onClickUpload(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      String taskText = taskController.text.toString();
      if (selectedTime != null) {
        TaskModel taskModel = TaskModel(
            task: taskText,
            date: selectedTime!,
            uId: FirebaseAuth.instance.currentUser?.uid ?? "abac");
        if (await firebaseService.addTask(taskModel)) {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      }
    }
  }

  void onClickUpdate(TaskModel task, BuildContext context) {
    if (formKey.currentState!.validate()) {
      String taskText = taskController.text.toString();

      TaskModel taskModel = TaskModel(
          task: taskText,
          date: selectedTime ?? time.toString(),
          uId: task.uId,
          docId: task.docId);

      firebaseService.updateTaskAndDate(taskModel);

      Navigator.of(context).pop();
    }
  }

  String? taskValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Task is required";
    }

    return null;
  }
}
