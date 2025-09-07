import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get apiBaseUrl => _get('apiBaseUrl');
  static String get apiKey => _get('apiKey');

  static String _get(String name) => dotenv.get(name);
}
