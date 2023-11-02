import 'package:flutter/material.dart';
import 'package:flutter_provider_test/todo/todo_view_model.dart';
import 'package:provider/provider.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  late TodoViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<TodoViewModel>();
    viewModel.getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'TODO',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<TodoViewModel>(
              builder: (context, value, child) {
                viewModel = value;
                return ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: taskCard(index),
                  ),
                  itemCount: viewModel.taskList.length,
                );
              },
            ),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            child: FloatingActionButton(
              onPressed: () => viewModel.onclickFAB(context),
              elevation: 10,
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget taskCard(int index) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      viewModel.getTaskData(index).task,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      viewModel.getTaskData(index).date,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => viewModel.editTask(
                context,
                index,
                true,
              ),
              icon: const Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
            ),
            IconButton(
              onPressed: () => viewModel.deleteTask(index),
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.disposeStream();
  }
}
