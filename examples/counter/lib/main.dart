import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_bloc/shared_preferences_bloc.dart';

class CounterCubit extends PrefCubit<int> {
  CounterCubit(SharedPreferences prefs) : super(prefs, 'counter', 0);

  void increment() {
    state = state + 1;
  }

  void decrement() {
    state = state - 1;
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            ElevatedButton(
              child: const Text("Increment"),
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
            ),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) => Text(" $state "),
            ),
            ElevatedButton(
              child: const Text("Decrement"),
              onPressed: () {
                context.read<CounterCubit>().decrement();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> main() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    BlocProvider(
      create: (context) => CounterCubit(sharedPreferences),
      child: const App(),
    ),
  );
}
