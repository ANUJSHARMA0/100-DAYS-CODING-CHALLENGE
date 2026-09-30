/// UnitConverterService handles conversions across categories
/// and multi-scale live cascade equivalents.
class UnitConverterService {
  static const List<String> categories = [
    'Length',
    'Mass',
    'Temperature',
    'Volume',
    'Speed',
    'Energy',
    'Pressure',
    'Data Storage'
  ];

  static Map<String, List<String>> unitsByCategory = {
    'Length': ['Meters (m)', 'Kilometers (km)', 'Statute Miles (mi)', 'Imperial Yards (yd)', 'Feet (ft)', 'Inches (in)', 'Nautical Miles (nmi)'],
    'Mass': ['Kilograms (kg)', 'Grams (g)', 'Pounds (lb)', 'Ounces (oz)', 'Metric Tons (t)'],
    'Temperature': ['Celsius (°C)', 'Fahrenheit (°F)', 'Kelvin (K)'],
    'Volume': ['Liters (L)', 'Milliliters (mL)', 'Gallons (gal)', 'Quarts (qt)', 'Cubic Meters (m³)'],
    'Speed': ['Meters/sec (m/s)', 'Kilometers/hour (km/h)', 'Miles/hour (mph)', 'Knots (kn)'],
    'Energy': ['Joules (J)', 'Kilojoules (kJ)', 'Calories (cal)', 'Kilocalories (kcal)', 'Watt-hours (Wh)'],
    'Pressure': ['Pascals (Pa)', 'Bar (bar)', 'Atmospheres (atm)', 'PSI (psi)'],
    'Data Storage': ['Bytes (B)', 'Kilobytes (KB)', 'Megabytes (MB)', 'Gigabytes (GB)', 'Terabytes (TB)'],
  };

  static double convert({
    required String category,
    required String fromUnit,
    required String toUnit,
    required double value,
  }) {
    if (fromUnit == toUnit) return value;

    if (category == 'Length') {
      double meters = _toMeters(fromUnit, value);
      return _fromMeters(toUnit, meters);
    } else if (category == 'Mass') {
      double kg = _toKg(fromUnit, value);
      return _fromKg(toUnit, kg);
    } else if (category == 'Temperature') {
      return _convertTemp(fromUnit, toUnit, value);
    } else if (category == 'Speed') {
      double ms = _toMs(fromUnit, value);
      return _fromMs(toUnit, ms);
    }

    return value * 1.0;
  }

  static Map<String, String> getCascadeEquivalents(String category, String fromUnit, double value) {
    Map<String, String> result = {};
    List<String> units = unitsByCategory[category] ?? [];
    for (String u in units) {
      if (u != fromUnit) {
        double conv = convert(category: category, fromUnit: fromUnit, toUnit: u, value: value);
        String name = u.split(' (')[0];
        String symbol = u.contains('(') ? u.split('(')[1].replaceAll(')', '') : '';
        result[name] = '${_formatDouble(conv)} $symbol';
      }
    }
    return result;
  }

  static double _toMeters(String unit, double val) {
    if (unit.contains('km')) return val * 1000.0;
    if (unit.contains('mi')) return val * 1609.344;
    if (unit.contains('yd')) return val * 0.9144;
    if (unit.contains('ft')) return val * 0.3048;
    if (unit.contains('in')) return val * 0.0254;
    if (unit.contains('nmi')) return val * 1852.0;
    return val;
  }

  static double _fromMeters(String unit, double meters) {
    if (unit.contains('km')) return meters / 1000.0;
    if (unit.contains('mi')) return meters / 1609.344;
    if (unit.contains('yd')) return meters / 0.9144;
    if (unit.contains('ft')) return meters / 0.3048;
    if (unit.contains('in')) return meters / 0.0254;
    if (unit.contains('nmi')) return meters / 1852.0;
    return meters;
  }

  static double _toKg(String unit, double val) {
    if (unit.contains('g')) return val / 1000.0;
    if (unit.contains('lb')) return val * 0.45359237;
    if (unit.contains('oz')) return val * 0.0283495231;
    if (unit.contains('t')) return val * 1000.0;
    return val;
  }

  static double _fromKg(String unit, double kg) {
    if (unit.contains('g')) return kg * 1000.0;
    if (unit.contains('lb')) return kg / 0.45359237;
    if (unit.contains('oz')) return kg / 0.0283495231;
    if (unit.contains('t')) return kg / 1000.0;
    return kg;
  }

  static double _convertTemp(String from, String to, double val) {
    double celsius = val;
    if (from.contains('°F')) celsius = (val - 32) * 5 / 9;
    if (from.contains('K')) celsius = val - 273.15;

    if (to.contains('°F')) return (celsius * 9 / 5) + 32;
    if (to.contains('K')) return celsius + 273.15;
    return celsius;
  }

  static double _toMs(String unit, double val) {
    if (unit.contains('km/h')) return val / 3.6;
    if (unit.contains('mph')) return val * 0.44704;
    if (unit.contains('kn')) return val * 0.514444;
    return val;
  }

  static double _fromMs(String unit, double ms) {
    if (unit.contains('km/h')) return ms * 3.6;
    if (unit.contains('mph')) return ms / 0.44704;
    if (unit.contains('kn')) return ms / 0.514444;
    return ms;
  }

  static String _formatDouble(double val) {
    if (val == val.toInt()) return val.toInt().toString();
    if (val > 100000 || (val < 0.0001 && val > 0)) {
      return val.toStringAsExponential(4);
    }
    String s = val.toStringAsFixed(4);
    return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
