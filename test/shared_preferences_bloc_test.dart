import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_bloc/shared_preferences_bloc.dart';

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

class CounterCubit extends PrefCubit<int> {
  CounterCubit(SharedPreferences prefs) : super(prefs, 'counter', 0);

  void increment() {
    state = state + 1;
  }

  void decrement() {
    state = state - 1;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences? shared_preferences;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    shared_preferences = await SharedPreferences.getInstance();
  });
  test('update int values', () {
    var sample = PrefCubit(shared_preferences!, 'sample', 0);

    sample.state = 5;

    sample = PrefCubit(shared_preferences!, 'sample', 0);

    expect(sample.state, 5);
  });

  test('update locale', () {
    var sample = LocaleCubit(shared_preferences!);

    sample.state = const Locale("es");

    var sample2 = LocaleCubit(shared_preferences!);

    expect(sample2.state, const Locale("es"));
  });

  test('update counter cubit', () {
    var sample = CounterCubit(shared_preferences!);

    expect(sample.state, 0);

    sample.increment();

    expect(sample.state, 1);

    var sample2 = CounterCubit(shared_preferences!);

    expect(sample2.state, 1);
  });
}
