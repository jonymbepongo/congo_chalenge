import 'dart:developer' as developer; // Pour un logging plus riche dans la console

abstract class AppLogger {
  // Log simple (informations générales)
  static void log(String message, {String tag = 'AppLog'}) {
    developer.log(message, name: tag);
  }

  // Log d'avertissement
  static void warning(String message, {String tag = 'AppWarning'}) {
    developer.log('⚠️ WARNING: $message', name: tag);
  }

  // Log d'erreur
  static void error(String message, {String tag = 'AppError', dynamic error, StackTrace? stackTrace}) {
    developer.log('❌ ERROR: $message', name: tag, error: error, stackTrace: stackTrace);
  }
}