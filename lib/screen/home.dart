import 'package:flutter/material.dart';
import 'package:todo_list/functions/file.dart';
import 'package:todo_list/model.dart/task_model.dart';
import 'package:todo_list/screen/new_task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WorkingWithFile file = WorkingWithFile();
  bool hasData = false;
  List<TaskModel> tasks = [];
  @override
  void initState() {
    checkData();
    super.initState();
  }

  checkData() async {
    tasks = await file.getData();
    hasData = tasks.isNotEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("To do"),
      ),
      body: hasData
          ? ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                TaskModel task = tasks[index];
                return ListTile(
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return AddNewTask(
                          edit: true,
                        );
                      },
                    ));
                  },
                  leading: Icon(task.completed
                      ? Icons.check_circle_sharp
                      : Icons.circle_outlined),
                  title: Text(task.title),
                  subtitle: Text(task.details),
                );
              },
            )
          : const Center(child: Text('empty')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewTask(),
              ));
        },
        tooltip: 'Add new Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
