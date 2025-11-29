import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.isCompleted,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Dismissible(
        key: Key(taskName),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 25),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(Icons.delete, color: Colors.white, size: 28),
        ),
        onDismissed: (_) => deleteTask!(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
            boxShadow: [
              // Soft glow shadow
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
              // Subtle highlight
              BoxShadow(
                color: Colors.white.withOpacity(0.7),
                blurRadius: 8,
                offset: const Offset(-3, -3),
              ),
            ],
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.3,
                child: CupertinoCheckbox(
                  value: isCompleted,
                  onChanged: onChanged,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color:
                        isCompleted ? Colors.grey.shade500 : Colors.grey.shade900,
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