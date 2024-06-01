import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_bloc/shared_preferences_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });
  test('update int values', () async {
    var sample = PrefCubit(await SharedPreferences.getInstance(), 'sample', 0);

    sample.value = 5;

    sample = PrefCubit(await SharedPreferences.getInstance(), 'sample', 0);

    expect(sample.state, 5);
  });
}
