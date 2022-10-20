// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
  TaskModel({
    this.title = "",
    this.details = "",
    this.completed = false,
  });

  String title;
  String details;
  bool completed;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"] ?? "",
        details: json["details"] ?? "",
        completed: json["completed"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "details": details,
        "completed": completed,
      };
}
