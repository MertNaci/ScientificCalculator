import 'package:flutter/material.dart';
import 'calculation_history.dart';

/// A right-side drawer panel that displays calculation history.
class HistoryPanel extends StatelessWidget {
  final CalculationHistory history;
  final void Function(String result) onRecordTap;
  final VoidCallback onClearHistory;

  const HistoryPanel({
    super.key,
    required this.history,
    required this.onRecordTap,
    required this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    final records = history.records;

    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF333333), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.history, color: Colors.white70, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'Geçmiş',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (records.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.redAccent, size: 22),
                      tooltip: 'Geçmişi Temizle',
                      onPressed: () {
                        onClearHistory();
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
            // History list
            Expanded(
              child: records.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calculate_outlined,
                              color: Colors.white24, size: 48),
                          SizedBox(height: 12),
                          Text(
                            'Henüz işlem yok',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        final record = records[index];
                        return _HistoryItem(
                          record: record,
                          onTap: () {
                            onRecordTap(record.result);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single history item widget.
class _HistoryItem extends StatelessWidget {
  final CalculationRecord record;
  final VoidCallback onTap;

  const _HistoryItem({
    required this.record,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF2A2A2A), width: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              record.expression,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            Text(
              '= ${record.result}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
