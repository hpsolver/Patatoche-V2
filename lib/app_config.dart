import 'enums/app_environment.dart';

class AppConfig {
  static AppEnvironment environment = AppEnvironment.dev;

  static String contentType = 'Content-Type';
  static String applicationJson = 'application/json';
  static String authorization = 'Authorization';
  static String bearer = 'Bearer ';

  static String contactNumber = '954621322365';
  static String email = 'suppport@email.com';

  static String get baseUrl {
    switch (environment) {
      case AppEnvironment.prod:
        return 'https://www.patatoche.com/wp-json/patatoche/v2/';
      case AppEnvironment.dev:
        return 'https://www.dev.patatoche.com/wp-json/patatoche/v2/';
    }
  }
}
