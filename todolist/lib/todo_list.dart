import 'package:flutter/material.dart';
import 'task_item.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'New Task',
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.blueAccent),
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      final newTask = taskController.text;
                      setState(() {
                        tasks.insert(0, newTask);
                      });
                      _listKey.currentState?.insertItem(0);
                      taskController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: tasks.length,
              itemBuilder: (context, index, animation) {
                return TaskItem(task: tasks[index], index: index, animation: animation, removeTask: _removeTask);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _removeTask(int index) {
    final removedTask = tasks[index];
    setState(() {
      tasks.removeAt(index);
    });
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => TaskItem(task: removedTask, index: index, animation: animation, removeTask: _removeTask),
    );
  }
}
