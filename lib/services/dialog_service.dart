import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/task_model.dart';
import 'package:flutter_provider_test/services/firestore_service.dart';
import 'package:flutter_provider_test/ui/todo/widget/task_dialog.dart';

class DialogService {
  Future<void> showAlertDialog(BuildContext context, String docId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(context, docId);
      },
    );
  }

  Future<void> showAddDialog(BuildContext context,
      {bool isEdit = false, TaskModel? taskModel}) async {
    print("show dialog is called");
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        print("Task model is called");
        return TaskDialog(
          isEdit: isEdit,
          taskModel: taskModel,
        );
      },
    );
  }

  AlertDialog _alertDialog(BuildContext context, String docId) {
    return AlertDialog(
      title: Text("Do you really want to delete ?"),
      actions: [
        ElevatedButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const Spacer(),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.redAccent.withOpacity(0.7))),
          onPressed: () {
            FirebaseService firebase = FirebaseService();
            // firebase.deleteImage(docId);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
