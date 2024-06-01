library shared_preferences_bloc;

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefCubit<T> extends Cubit<T> {
  final SharedPreferences _prefs;
  final String _prefKey;
  final String Function(T)? _mapTo; // Optional for custom type conversion
  final T? Function(String)? _mapFrom;

  PrefCubit(
    this._prefs,
    this._prefKey,
    T defaultValue, [
    this._mapTo,
    this._mapFrom,
  ]) : super(
          (_mapFrom != null
                  ? _mapFrom(_prefs.get(_prefKey).toString())
                  : _prefs.get(_prefKey)) as T? ??
              defaultValue,
        ) {
    _saveValue(state); // Save initial state to SharedPreferences
  }

  set value(T newValue) {
    _saveValue(newValue);
    emit(newValue);
  }

  Future<void> _saveValue(T value) async {
    if (_mapTo != null) {
      await _prefs.setString(_prefKey, _mapTo!(value));
    } else if (value is String) {
      await _prefs.setString(_prefKey, value);
    } else if (value is bool) {
      await _prefs.setBool(_prefKey, value);
    } else if (value is int) {
      await _prefs.setInt(_prefKey, value);
    } else if (value is double) {
      await _prefs.setDouble(_prefKey, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(_prefKey, value);
    }
  }
}
