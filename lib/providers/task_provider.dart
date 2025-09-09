import 'package:flutter/material.dart';

class Task {
  final String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(title: 'Complete Math Quiz'),
    Task(title: 'Science Experiment', isCompleted: true),
    Task(title: 'Diss Kendrick Lamar'),
  ];

  List<Task> get tasks => _tasks;

  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }
}
