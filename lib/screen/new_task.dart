import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/functions/file.dart';

class AddNewTask extends StatefulWidget {
  bool edit;
  AddNewTask({super.key, this.edit = false});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController title = TextEditingController();
  TextEditingController details = TextEditingController();
  WorkingWithFile file = WorkingWithFile();

  @override
  void dispose() {
    title.dispose();
    details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.edit ? "Edit Task" : "Add New Task")),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: title,
            ),
            Expanded(
              child: TextField(
                controller: details,
                minLines: null,
                maxLines: null,
                expands: true,
              ),
            )
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Row(
            children: [
              IconButton(
                  onPressed: () async {
                    var json = [
                      {"title": title.text, "completed": false}
                    ];
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
