class ConstantItem {
  final String symbol;
  final String name;
  final String value;
  final String formattedValue;
  final String unit;
  final String category; // 'Quantum Physics', 'Astrophysics', 'Thermodynamics', 'Electromagnetism', 'Math Constants'

  const ConstantItem({
    required this.symbol,
    required this.name,
    required this.value,
    required this.formattedValue,
    required this.unit,
    required this.category,
  });
}

class FormulaItem {
  final String title;
  final String category;
  final String formula;
  final String description;
  final List<String> variables;

  const FormulaItem({
    required this.title,
    required this.category,
    required this.formula,
    required this.description,
    required this.variables,
  });
}
