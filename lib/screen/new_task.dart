import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/functions/file.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController title = TextEditingController();
  WorkingWithFile file = WorkingWithFile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Task")),
      body: SafeArea(
        child: Column(
          children: [TextField(controller: title), RichText(text: TextSpan())],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Row(
            children: [
              IconButton(
                  onPressed: () async {
                    var json = {"title": title.text, "completed": false};
                    await file.write(jsonEncode(json));
                  },
                  icon: Icon(Icons.edit)),
            ],
          );
        },
      ),
    );
  }
}
