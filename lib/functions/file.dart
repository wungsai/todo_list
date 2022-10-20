import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model.dart/task_model.dart';

class WorkingWithFile {
  final String _fileName = 'task.txt';
  Future _getFile() async {
    File file;
    var dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/$_fileName');
    if (await File('${dir.path}/$_fileName').exists()) {
      log("exist");
      return file;
    } else {
      file.create();
      log("new");
      return file;
    }
  }

  Future getData() async {
    List<TaskModel> taskList = [];
    String raw = await readFile();
    if (raw.isNotEmpty && raw != "") {
      Map<String, Map<String, dynamic>> fromFile = Map.from(json.decode(raw));
      taskList =
          List.from(fromFile.values.map((e) => TaskModel.fromJson(e)).toList());
    }

    return taskList;
  }

  Future<String> readFile() async {
    File file = await _getFile();
    String text;
    text = await file.readAsString();
    log("text: $text");
    return text;
  }

  Future write(String data) async {
    File file = await _getFile();
    file.writeAsString(data);
  }

  Future updateStatus(String id) async {
    Map<String, Map<String, dynamic>> raw =
        Map.from(jsonDecode(await readFile()));
    Map<String, TaskModel> t =
        raw.map((key, value) => MapEntry(key, TaskModel.fromJson(value)));
    t[id]!.completed = !t[id]!.completed;
    String save = jsonEncode(t);
    write(save);
  }
}
