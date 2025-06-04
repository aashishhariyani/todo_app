
import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class Task {
  String title;
  Task(this.title);
}

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final List<Task> tasks = [];
  final TextEditingController titleController = TextEditingController();
  int? editingIndex;

  void addOrEditTask() {
    if (titleController.text.isNotEmpty) {
      setState(() {
        if (editingIndex == null) {
          tasks.add(Task(titleController.text));
        } else {
          tasks[editingIndex!] = Task(titleController.text);
          editingIndex = null;
        }
        titleController.clear();
      });
    }
  }

  void editTask(int index) {
    setState(() {
      titleController.text = tasks[index].title;
      editingIndex = index;
    });
  }

  void deleteTask(int index) {
    setState(() {
      if (editingIndex == index) {
        titleController.clear();
        editingIndex = null;
      }
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("To-Do App with Task Titles & Edit")),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: editingIndex == null ? "Enter task title" : "Edit task title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: addOrEditTask,
                child: Text(editingIndex == null ? "Add Task" : "Update Task"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(tasks[index].title),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editTask(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteTask(index),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
