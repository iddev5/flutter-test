import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Todos')),
      body: Todo(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ListPage(),
          ));
        },
        shape: const RoundedRectangleBorder(),
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("ok");
  }
}

typedef ItemChangeCallback = Function(int index, bool changed);

class TodoItem extends StatelessWidget {
  const TodoItem({
    required this.id,
    required this.task,
    required this.onChanged,
    super.key,
  });

  final int id;
  final Task task;
  final ItemChangeCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
        value: task.checked,
        onChanged: (ch) {
          if (ch != null) {
            onChanged(id, ch);
          }
        },
      ),
      const SizedBox(width: 20),
      Text(task.text),
    ]);
  }
}

class Task {
  Task({required this.text});

  String text;
  bool checked = false;
}

class Todo extends StatefulWidget {
  Todo({super.key});

  final List<Task> todos = [
    Task(text: "Okay"),
    Task(text: "Hiyo"),
  ];

  @override
  State<Todo> createState() => TodoState();
}

class TodoState extends State<Todo> {
  void handleItemChange(int index, bool checked) {
    setState(() {
      widget.todos[index].checked = checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.todos
          .asMap()
          .entries
          .map((elem) => TodoItem(
                id: elem.key,
                task: elem.value,
                onChanged: handleItemChange,
              ))
          .toList(),
    );
  }
}
