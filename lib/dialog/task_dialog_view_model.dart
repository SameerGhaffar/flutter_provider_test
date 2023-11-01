// import 'package:flutter/material.dart';
// import 'package:flutter_getx_test/model/task_model.dart';
// import 'package:flutter_getx_test/services/auth_service.dart';
// import 'package:flutter_getx_test/services/firestore_service.dart';
// import 'package:get/get.dart';
//
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/task_model.dart';
import 'package:flutter_provider_test/services/auth_service.dart';
import 'package:flutter_provider_test/services/firestore_service.dart';

class TaskDialogViewModel with ChangeNotifier {
  TextEditingController taskController = TextEditingController();

  // Rx<TimeOfDay?> time = TimeOfDay.now().obs;
  // Rx<String> selectedTime = "".obs;
  TimeOfDay? time;
  String? selectedTime;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseService firestoreService = FirebaseService();
  final AuthService authService = AuthService();

  timePicker(BuildContext context) async {
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time!= null) {
      selectedTime = time!.format(context).toString();
      print(selectedTime);
    }
  }

  onClickUpload(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      String taskText = taskController.text.toString();
      if (selectedTime != null) {
        TaskModel taskModel = TaskModel(
            task: taskText,
            date: selectedTime!,
            uId: authService.user?.uid ?? "abac");
        if (await firestoreService.addTask(taskModel)) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  onClickUpdate(TaskModel task) {
    if (formKey.currentState!.validate()) {
      String taskText = taskController.text.toString();

      TaskModel taskModel = TaskModel(
          task: taskText,
          date: selectedTime.value ?? time.value.toString(),
          uId: task.uId,
          docId: task.docId);

      firestoreService.updateTaskAndDate(taskModel);
      Get.back();
    }
  }

  String? taskValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Task is required";
    }

    return null;
  }
}
