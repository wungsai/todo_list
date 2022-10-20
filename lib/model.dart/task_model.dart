import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
  TaskModel({
    this.id = "",
    this.title = "",
    this.details = "",
    this.completed = false,
  });
  String id;
  String title;
  String details;
  bool completed;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      details: json["details"] ?? "",
      completed: json["completed"] ?? false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "details": details,
        "completed": completed,
      };
}
