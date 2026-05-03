/// Represents a single calculation record with the expression and its result.
class CalculationRecord {
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculationRecord({
    required this.expression,
    required this.result,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// Manages the calculation history as an in-memory list.
class CalculationHistory {
  final List<CalculationRecord> _records = [];

  /// Returns all records, most recent first.
  List<CalculationRecord> get records => List.unmodifiable(_records.reversed);

  /// Adds a new calculation record to the history.
  void add(String expression, String result) {
    _records.add(CalculationRecord(expression: expression, result: result));
  }

  /// Clears all history records.
  void clear() {
    _records.clear();
  }

  /// Returns the number of records.
  int get length => _records.length;

  /// Returns true if there are no records.
  bool get isEmpty => _records.isEmpty;
}
