import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String task;
  final int index;
  final Animation<double> animation;
  final Function(int) removeTask;

  TaskItem({required this.task, required this.index, required this.animation, required this.removeTask});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(
              task,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => removeTask(index),
            ),
          ),
        ),
      ),
    );
  }
}
