import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class AppState extends ChangeNotifier {
  var count = 0;

  void increment() {
    count += 1;
    notifyListeners();
  }

  void decrement() {
    if (count != 0) {
      count -= 1;
    }
    notifyListeners();
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Counter',
        home: Scaffold(
          appBar: AppBar(title: const Text('Counter')),
          body: const HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();

    return Column(
      children: [
        Text('${state.count}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => state.increment(),
              child: const Text('+'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => state.decrement(),
              child: const Text('-'),
            ),
          ],
        ),
      ],
    );
  }
}
