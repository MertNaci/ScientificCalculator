import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

/// Calculator engine that evaluates mathematical expressions
/// including scientific functions (sin, cos, tan, log, sqrt, power).
class CalculatorEngine {
  final Parser _parser = Parser();
  final ContextModel _contextModel = ContextModel();

  /// Evaluates a mathematical expression string and returns the result.
  /// Supports: +, -, *, /, ^, sin, cos, tan, log, sqrt, parentheses.
  String evaluate(String expression) {
    try {
      // Pre-process the expression for the parser
      String processed = _preProcess(expression);

      // Parse and evaluate
      Expression exp = _parser.parse(processed);
      double result = exp.evaluate(EvaluationType.REAL, _contextModel);

      // Format the result (remove trailing .0 for integers)
      if (result == result.toInt().toDouble()) {
        return result.toInt().toString();
      } else {
        return result.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      return 'Error';
    }
  }

  /// Pre-processes the expression string to make it compatible
  /// with the math_expressions parser.
  String _preProcess(String expression) {
    String result = expression;

    // Replace display operators with math operators
    result = result.replaceAll('×', '*');
    result = result.replaceAll('÷', '/');

    // Replace sqrt( with sqrt( - math_expressions uses sqrt()
    // No change needed, parser supports sqrt natively

    // Replace log( with log( base 10 using ln
    // math_expressions log is natural log (ln), we need log10
    // log10(x) = ln(x) / ln(10)
    result = result.replaceAllMapped(
      RegExp(r'log\(([^)]+)\)'),
      (match) => '(ln(${match.group(1)})/ln(10))',
    );

    return result;
  }
}
