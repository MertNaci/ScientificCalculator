import 'package:flutter/material.dart';
import 'calculator_button.dart';
import 'calculator_engine.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _display = '0';
  final CalculatorEngine _engine = CalculatorEngine();

  // Color constants matching the design
  static const Color scientificButtonColor = Color(0xFF8FA4B0);
  static const Color numberButtonColor = Color(0xFF3B3B3B);
  static const Color operatorButtonColor = Color(0xFFFF9800);
  static const Color deleteButtonColor = Color(0xFFE57373);
  static const Color clearButtonColor = Color(0xFFE53935);
  static const Color equalsButtonColor = Color(0xFF4CAF50);

  void _onButtonPressed(String value) {
    setState(() {
      switch (value) {
        case 'C':
          _clear();
          break;
        case '⌫':
          _backspace();
          break;
        case '=':
          _evaluate();
          break;
        default:
          _appendValue(value);
          break;
      }
    });
  }

  void _clear() {
    _expression = '';
    _display = '0';
  }

  void _backspace() {
    if (_expression.isNotEmpty) {
      // Handle multi-character deletions (sin(, cos(, tan(, log(, sqrt()
      if (_expression.endsWith('sin(')) {
        _expression = _expression.substring(0, _expression.length - 4);
      } else if (_expression.endsWith('cos(')) {
        _expression = _expression.substring(0, _expression.length - 4);
      } else if (_expression.endsWith('tan(')) {
        _expression = _expression.substring(0, _expression.length - 4);
      } else if (_expression.endsWith('log(')) {
        _expression = _expression.substring(0, _expression.length - 4);
      } else if (_expression.endsWith('sqrt(')) {
        _expression = _expression.substring(0, _expression.length - 5);
      } else {
        _expression = _expression.substring(0, _expression.length - 1);
      }
      _display = _expression.isEmpty ? '0' : _expression;
    }
  }

  void _appendValue(String value) {
    // If display is '0', replace it (unless it's a decimal point or operator)
    if (_expression == '0' && value != '.' && !_isOperator(value)) {
      _expression = value;
      _display = _expression;
      return;
    }

    // Get the last character of the current expression
    String lastChar = _expression.isNotEmpty
        ? _expression[_expression.length - 1]
        : '';

    // Prevent consecutive operators: replace the last operator with the new one
    if (_isOperator(value) && _isOperatorChar(lastChar)) {
      _expression = _expression.substring(0, _expression.length - 1) + value;
      _display = _expression;
      return;
    }

    // Prevent operator at the very beginning (except minus for negative numbers)
    if (_expression.isEmpty && _isOperator(value) && value != '-') {
      return;
    }

    // Prevent multiple decimal points in the same number
    if (value == '.') {
      // Find the last number segment (after the last operator or parenthesis)
      String lastNumber = _getLastNumberSegment();
      if (lastNumber.contains('.')) {
        return;
      }
    }

    _expression += value;
    _display = _expression;
  }

  /// Returns the last number segment from the expression
  /// (everything after the last operator or parenthesis)
  String _getLastNumberSegment() {
    String segment = '';
    for (int i = _expression.length - 1; i >= 0; i--) {
      String ch = _expression[i];
      if (_isOperatorChar(ch) || ch == '(' || ch == ')') {
        break;
      }
      segment = ch + segment;
    }
    return segment;
  }

  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == '×' || value == '÷';
  }

  bool _isOperatorChar(String ch) {
    return ch == '+' || ch == '-' || ch == '×' || ch == '÷';
  }

  void _evaluate() {
    if (_expression.isEmpty) return;
    String result = _engine.evaluate(_expression);
    _display = result;
    if (result != 'Error') {
      _expression = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Scientific Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display area
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      _display,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Scientific function buttons - Row 1
          Row(
            children: [
              CalculatorButton(
                text: 'sin(',
                backgroundColor: scientificButtonColor,
                onPressed: () => _onButtonPressed('sin('),
              ),
              CalculatorButton(
                text: 'cos(',
                backgroundColor: scientificButtonColor,
                onPressed: () => _onButtonPressed('cos('),
              ),
              CalculatorButton(
                text: 'tan(',
                backgroundColor: scientificButtonColor,
                onPressed: () => _onButtonPressed('tan('),
              ),
              CalculatorButton(
                text: 'log(',
                backgroundColor: scientificButtonColor,
                onPressed: () => _onButtonPressed('log('),
              ),
            ],
          ),
          // Scientific function buttons - Row 2
          Row(
            children: [
              CalculatorButton(
                text: 'sqrt(',
                backgroundColor: scientificButtonColor,
                onPressed: () => _onButtonPressed('sqrt('),
              ),
              CalculatorButton(
                text: '^',
                backgroundColor: scientificButtonColor,
                onPressed: () => _onButtonPressed('^'),
              ),
              CalculatorButton(
                text: '(',
                backgroundColor: scientificButtonColor,
                onPressed: () => _onButtonPressed('('),
              ),
              CalculatorButton(
                text: ')',
                backgroundColor: scientificButtonColor,
                onPressed: () => _onButtonPressed(')'),
              ),
            ],
          ),
          // Number pad row: 7, 8, 9, +
          Row(
            children: [
              CalculatorButton(
                text: '7',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('7'),
              ),
              CalculatorButton(
                text: '8',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('8'),
              ),
              CalculatorButton(
                text: '9',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('9'),
              ),
              CalculatorButton(
                text: '+',
                backgroundColor: operatorButtonColor,
                onPressed: () => _onButtonPressed('+'),
              ),
            ],
          ),
          // Number pad row: 4, 5, 6, ×
          Row(
            children: [
              CalculatorButton(
                text: '4',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('4'),
              ),
              CalculatorButton(
                text: '5',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('5'),
              ),
              CalculatorButton(
                text: '6',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('6'),
              ),
              CalculatorButton(
                text: '×',
                backgroundColor: operatorButtonColor,
                onPressed: () => _onButtonPressed('×'),
              ),
            ],
          ),
          // Number pad row: 1, 2, 3, -
          Row(
            children: [
              CalculatorButton(
                text: '1',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('1'),
              ),
              CalculatorButton(
                text: '2',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('2'),
              ),
              CalculatorButton(
                text: '3',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('3'),
              ),
              CalculatorButton(
                text: '-',
                backgroundColor: operatorButtonColor,
                onPressed: () => _onButtonPressed('-'),
              ),
            ],
          ),
          // Number pad row: 0, ., ⌫, ÷
          Row(
            children: [
              CalculatorButton(
                text: '0',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('0'),
              ),
              CalculatorButton(
                text: '.',
                backgroundColor: numberButtonColor,
                onPressed: () => _onButtonPressed('.'),
              ),
              CalculatorButton(
                text: '⌫',
                backgroundColor: deleteButtonColor,
                onPressed: () => _onButtonPressed('⌫'),
              ),
              CalculatorButton(
                text: '÷',
                backgroundColor: operatorButtonColor,
                onPressed: () => _onButtonPressed('÷'),
              ),
            ],
          ),
          // Bottom row: C and =
          Row(
            children: [
              CalculatorButton(
                text: 'C',
                backgroundColor: clearButtonColor,
                flex: 2,
                onPressed: () => _onButtonPressed('C'),
              ),
              CalculatorButton(
                text: '=',
                backgroundColor: equalsButtonColor,
                flex: 2,
                onPressed: () => _onButtonPressed('='),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
