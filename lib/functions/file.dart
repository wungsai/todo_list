import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model.dart/task_model.dart';

class WorkingWithFile {
  late File file;

  WorkingWithFile() {
    getFile();
  }
  String fileName = 'task.txt';
  Future getFile() async {
    log("getFile");
    List<TaskModel> taskList = [];
    String text;
    var dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/$fileName');
    if (await File('${dir.path}/$fileName').exists()) {
      text = await file.readAsString();
      {
        var fromFile = json.decode(text);
        var toList = fromFile.cast<Map<String, dynamic>>();
        taskList =
            toList.map<TaskModel>((json) => taskModelFromJson(json)).toList();
        log("Data: " + jsonEncode(taskList));
      }
      return file;
    } else {
      file.create();
      return file;
    }
  }

  Future write(String data) async {
    file.writeAsString(data);
  }
}
