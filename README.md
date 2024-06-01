<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# SharedPreferences_bloc

Make it easier to access SharePreferences using Bloc's Cubit.

- https://pub.dev/packages/shared_preferences
- https://pub.dev/packages/bloc

## Getting started

<!--
TODO: List prerequisites and provide or point to information on how to
start using the package.
-->

Add to your dependencies ```pubspec.yaml```

```yaml
dependencies:
  shared_preferences_bloc:
    git:
      url: https://github.com/CarlosRA97/shared_preferences_bloc.git
```

## Usage

### Primitive type or List\<String\>

- Create `Cubit` with `PrefCubit` and generics parameter.

```dart
class CounterCubit extends PrefCubit<int> {
  CounterCubit(SharedPreferences prefs) : super(prefs, 'counter', 0);

  void increment() {
    state = state + 1;
  }

  void decrement() {
    state = state - 1;
  }
}
```

- Refer values with `context.watch<CounterCubit>().state`.
- Update value with `context.read<CounterCubit>().state = newValue;`.

```dart
BlocBuilder<CounterCubit, int>(
  builder: (context, state) => Text(" $state "),
)
```
### Other types

- Create `Cubit` with `PrefCubit` and map functions.

```dart
class LocaleCubit extends PrefCubit<Locale?> {
  LocaleCubit(SharedPreferences prefs)
      : super(
    prefs,
    'appLanguage',
    null,
        (locale) => locale.toString(),
        (locale) => Locale(locale),
  );
}
```

- Refer values with `context.watch<LocaleCubit>().state`.
- Update value with `context.read<LocaleCubit>().state = Locale(newValue);`.

```dart
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Row(
        children: [
          ElevatedButton(
            child: const Text("ES"),
            onPressed: () {
              context.read<LocaleCubit>().state = Locale('es');
            },
          ),
          BlocBuilder<LocaleCubit, Locale?>(
            builder: (context, state) => Text(" ${state?.languageCode} "),
          ),
          ElevatedButton(
            child: const Text("EN"),
            onPressed: () {
              context.read<LocaleCubit>().state = Locale('en');
            },
          ),
        ],
      ),
    ),
  );
}
```

### Example

```dart

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


```

## Inspired by
- https://github.com/gamako/shared_preferences_riverpod