import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_list/functions/file.dart';

class AddNewTask extends StatefulWidget {
  final String id;
  final String title;
  final String details;
  final bool edit;
  const AddNewTask(
      {super.key,
      this.edit = false,
      this.id = '',
      this.title = '',
      this.details = ''});

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
  void initState() {
    title.text = widget.title;
    details.text = widget.details;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.edit ? "Edit Task" : "Add New Task")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: title,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: TextField(
                  decoration:
                      const InputDecoration(hintText: "Details........"),
                  keyboardType: TextInputType.text,
                  controller: details,
                  minLines: null,
                  maxLines: null,
                  expands: true,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50.0,
                  onPressed: () async {
                    // file.write('');
                    String id = widget.edit
                        ? widget.id
                        : DateTime.now().microsecondsSinceEpoch.toString();

                    String raw = await file.readFile();

                    Map<String, Map<String, dynamic>> data = {};
                    if (raw.isNotEmpty && raw != "") {
                      data = Map.from(jsonDecode(raw));
                    }

                    if (widget.edit) {
                      Map<String, dynamic> json = {
                        "id": id,
                        "title": title.text,
                        "details": details.text,
                        "completed": false
                      };
                      data.update(
                        widget.id,
                        (value) => json,
                      );

                      // return;
                    } else {
                      Map<String, Map<String, dynamic>> json = {
                        id: {
                          "id": id,
                          "title": title.text,
                          "details": details.text,
                          "completed": false
                        }
                      };
                      data.addAll(json);
                    }
                    String ready = jsonEncode(data);

                    // return;
                    await file.write(ready);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save),
                  color: Colors.green,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
