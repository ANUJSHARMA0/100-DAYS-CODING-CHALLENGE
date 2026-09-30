class TapeEntry {
  final String id;
  final String title;
  final String expression;
  final String result;
  final String timestamp;
  final String category; // 'physics', 'trig', 'calculus', 'general'
  final String? note;
  final String? unit;
  bool isStarred;

  TapeEntry({
    required this.id,
    required this.title,
    required this.expression,
    required this.result,
    required this.timestamp,
    required this.category,
    this.note,
    this.unit,
    this.isStarred = false,
  });
}
