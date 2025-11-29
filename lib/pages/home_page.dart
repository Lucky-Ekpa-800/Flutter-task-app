import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revision/utils/dialog_box.dart';
import 'package:revision/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todoList = [
    ['Hit the gym', false],
    ['Go to the grocery store', true],
  ];

  final TextEditingController _controller = TextEditingController();

  void checkBoxChange(bool? value, int index) {
    setState(() {
      todoList[index][1] = value;
    });
  }

  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: () {
            _controller.clear();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void saveTask() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      todoList.add([_controller.text, false]);
    });

    _controller.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // ------- GLASSMORPHISM HEADER -------
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(90),
  child: ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        padding: const EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.grey.shade200.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "My Tasks",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    ),
  ),
),
      // ------- STYLISH GRADIENT FAB -------
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.blueAccent.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 30),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.only(top: 12),
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: todoList[index][0],
            isCompleted: todoList[index][1],
            onChanged: (value) => checkBoxChange(value, index),
            deleteTask: (_) => deleteTask(index),
          );
        },
      ),
    );
  }
}