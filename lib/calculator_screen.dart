import 'package:flutter/material.dart';
import 'calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';

  // Color constants matching the design
  static const Color scientificButtonColor = Color(0xFF8FA4B0);
  static const Color numberButtonColor = Color(0xFF3B3B3B);
  static const Color operatorButtonColor = Color(0xFFFF9800);
  static const Color deleteButtonColor = Color(0xFFE57373);
  static const Color clearButtonColor = Color(0xFFE53935);
  static const Color equalsButtonColor = Color(0xFF4CAF50);

  void _onButtonPressed(String value) {
    // Logic will be implemented in later commits
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
              padding: const EdgeInsets.all(20),
              color: Colors.black,
              alignment: Alignment.bottomRight,
              child: Text(
                _display,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
          // Remaining buttons will be added in the next commit
          Expanded(
            flex: 3,
            child: Container(
              color: numberButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}
