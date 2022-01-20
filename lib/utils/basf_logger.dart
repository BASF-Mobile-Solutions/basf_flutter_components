import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:basf_flutter_components/functions/scope_functions.dart';

/// [basfLogger] based on [logger], ready to use
/// Small, easy to use and extensible logger which prints beautiful logs
/// 
/// Just type [basfLogger] and start logging
/// ```dart
///  basfLogger.d('BASF Logger is working');
/// ```
/// 
/// Instead of a [string] message, you can also pass other objects like [List], [Map] or [Set]
///
/// You can log with different levels
/// 
/// Example:
/// ```dart
///  basfLogger.v('Verbose log...');
///  basfLogger.d('Debug log');
///  basfLogger.i('Info log...');
///  basfLogger.w('Warning log');
///  basfLogger.e('Error log...');
///  basfLogger.wtf('👾 What a terrible failure log');
/// ```
Logger get basfLogger => _logger;

Logger _logger = Logger(printer: DevelopmentLogPrinter());

class DevelopmentLogPrinter extends PrettyPrinter {
  DevelopmentLogPrinter() : super(lineLength: 180);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level]!;
    final prefix = _getPrefix(event.level);

    final message = stringifyMessage(event.message);
    final error = event.error?.let((e) => e.toString());
    final errorStackTrace =
        event.stackTrace?.let((st) => formatStackTrace(st, methodCount)) ?? '';

    return [
      ..._formatMessage(color, prefix, message),
      if (error != null) ..._formatError(color, prefix, error, errorStackTrace),
    ];
  }

  String get _callerClassName {
    const callerClassPosition = 5;
    final stacktrace = StackTrace.current.toString();
    final stLines = stacktrace.trim().split('\n');
    if (stLines.length > callerClassPosition) {
      final line = stLines[callerClassPosition];
      return line.substring(2, line.indexOf('.')).replaceAll(' ', '');
    }
    return 'UNKNOWN';
  }

  String _getPrefix(Level level) {
    final emoji = PrettyPrinter.levelEmojis[level]!;
    final logLevel = describeEnum(level);
    final time = DateTime.now().toIso8601String();
    final className = _callerClassName;

    return '$emoji [$logLevel] $time <$className>';
  }

  List<String> _formatMessage(AnsiColor color, String prefix, String message) =>
      [for (var line in message.split('\n')) color('$prefix: $line')];

  List<String> _formatError(
      AnsiColor color, String prefix, String error, String errorStackTrace) {
    final errorColor = PrettyPrinter.levelColors[Level.error]!;

    return [
      '$prefix ERROR: ',
      for (var line in error.split('\n')) errorColor(line),
      for (var line in errorStackTrace.split('\n')) '$color $line',
      '',
    ];
  }
}
