import 'package:flutter/material.dart';
import 'task_item.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // Lista para armazenar as tarefas com status
  List<Map<String, dynamic>> tasks = [];
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                      final newTask = {'task': taskController.text, 'done': false}; // Tarefa não concluída inicialmente
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
                return TaskItem(
                  task: tasks[index]['task'],
                  isDone: tasks[index]['done'],
                  index: index,
                  animation: animation,
                  toggleTaskStatus: _toggleTaskStatus,
                  removeTask: _removeTask,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Função para alternar o estado da tarefa (concluída ou não)
  void _toggleTaskStatus(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  void _removeTask(int index) {
    final removedTask = tasks[index];
    setState(() {
      tasks.removeAt(index);
    });
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => TaskItem(
        task: removedTask['task'],
        isDone: removedTask['done'],
        index: index,
        animation: animation,
        toggleTaskStatus: _toggleTaskStatus,
        removeTask: _removeTask,
      ),
    );
  }
}
