import 'package:edutech_app/features/student/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskListController extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(title: 'Complete Math Quiz'),
    Task(title: 'Science Experiment'),
    Task(title: 'Diss Kendrick Lamar'),
  ];
  List<Task> get tasks => _tasks;
  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }
}
