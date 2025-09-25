import 'dart:developer' as dev;

class LoggerService {
  static void info(
      String message, {
        Object? context,
        Object? error,
        StackTrace? stackTrace,
      }) {
    dev.log(
      message,
      name: context?.runtimeType.toString() ?? 'INFO',
      error: error,
      stackTrace: stackTrace,
      level: 800,
    );
  }

  static void warning(
      String message, {
        Object? context,
        Object? error,
        StackTrace? stackTrace,
      }) {
    dev.log(
      message,
      name: context?.runtimeType.toString() ?? 'WARNING',
      error: error,
      stackTrace: stackTrace,
      level: 900,
    );
  }

  static void error(
      String message, {
        Object? context,
        Object? error,
        StackTrace? stackTrace,
      }) {
    dev.log(
      message,
      name: context?.runtimeType.toString() ?? 'ERROR',
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }

  static void log(
      String message, {
        Object? context,
        Object? error,
        StackTrace? stackTrace,
        int level = 800,
      }) {
    dev.log(
      message,
      name: context?.runtimeType.toString() ?? 'LOG',
      error: error,
      stackTrace: stackTrace,
      level: level,
    );
  }
}
