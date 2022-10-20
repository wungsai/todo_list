import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model.dart/task_model.dart';

class WorkingWithFile {
  String fileName = 'task.txt';
  Future _getFile() async {
    log("getFile");
    File file;
    var dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/$fileName');
    if (await File('${dir.path}/$fileName').exists()) {
      return file;
    } else {
      file.create();
      return file;
    }
  }

  Future getData() async {
    File file = await _getFile();
    List<TaskModel> taskList = [];
    String text;
    text = await file.readAsString();
    {
      List fromFile = json.decode(text);
      taskList = taskModelFromJson(text);
    }
    return taskList;
  }

  Future write(String data) async {
    File file = await _getFile();
    file.writeAsString(data);
  }
}
