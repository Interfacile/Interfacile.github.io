import 'package:hive/hive.dart';

class IFPreferences {
  static const String preferencesBox = 'preferences';
  final Box<dynamic> _box;

  IFPreferences._(this._box);
  
  static IFPreferences getInstance() {
    final box = Hive.box<dynamic>(preferencesBox);
    return IFPreferences._(box);
  }

  T getValue<T>(dynamic key, {T? defaultValue}) => _box.get(key, defaultValue: defaultValue) as T;

  Future<void> setValue<T>(dynamic key, T value) => _box.put(key, value);
}