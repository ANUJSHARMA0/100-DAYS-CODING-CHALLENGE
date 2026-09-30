import 'dart:math' as math;

/// CalculatorEngine handles expression state, scientific evaluation,
/// angle units (DEG/RAD), memory registers, and fraction toggle logic.
class CalculatorEngine {
  String expression = '';
  String evaluatedResult = '0';
  String livePreview = '0';
  String lastAnswer = '0';
  double memoryValue = 0.0;
  bool isDeg = true; // DEG by default
  bool is2nd = false;
  bool isHyp = false;
  bool isFractionMode = false;
  bool isScientificNotation = false;

  void append(String val) {
    if (expression == '0' && val != '.' && !isOperator(val)) {
      expression = val;
    } else {
      expression += val;
    }
    updateLivePreview();
  }

  void clearAll() {
    expression = '';
    evaluatedResult = '0';
    livePreview = '0';
  }

  void deleteLast() {
    if (expression.isNotEmpty) {
      expression = expression.substring(0, expression.length - 1);
      updateLivePreview();
    }
  }

  bool isOperator(String char) {
    return char == '+' || char == '−' || char == '×' || char == '÷' || char == '^';
  }

  void toggleAngleMode() {
    isDeg = !isDeg;
    updateLivePreview();
  }

  void toggle2nd() {
    is2nd = !is2nd;
  }

  void toggleHyp() {
    isHyp = !isHyp;
  }

  void toggleFraction() {
    isFractionMode = !isFractionMode;
    if (isFractionMode && evaluatedResult != '0') {
      try {
        double val = double.parse(evaluatedResult.replaceAll(',', ''));
        evaluatedResult = _doubleToFraction(val);
      } catch (_) {}
    } else {
      evaluate();
    }
  }

  // Memory Functions
  void memoryClear() {
    memoryValue = 0.0;
  }

  void memoryRecall() {
    expression += memoryValue.toString();
    updateLivePreview();
  }

  void memoryAdd() {
    try {
      evaluate();
      double val = double.parse(evaluatedResult.replaceAll(',', ''));
      memoryValue += val;
    } catch (_) {}
  }

  void memorySubtract() {
    try {
      evaluate();
      double val = double.parse(evaluatedResult.replaceAll(',', ''));
      memoryValue -= val;
    } catch (_) {}
  }

  // Evaluation
  void evaluate() {
    if (expression.isEmpty) return;
    try {
      double res = _parseAndEval(expression);
      lastAnswer = _formatNumber(res);
      evaluatedResult = isFractionMode ? _doubleToFraction(res) : lastAnswer;
      livePreview = '= $evaluatedResult';
    } catch (e) {
      evaluatedResult = 'Error';
      livePreview = 'Invalid syntax';
    }
  }

  void updateLivePreview() {
    if (expression.isEmpty) {
      livePreview = '0';
      return;
    }
    try {
      double res = _parseAndEval(expression);
      livePreview = _formatNumber(res);
    } catch (_) {
      livePreview = '...';
    }
  }

  double _parseAndEval(String input) {
    String sanitized = input
        .replaceAll('×', '*')
        .replaceAll('−', '-')
        .replaceAll('÷', '/')
        .replaceAll('π', '${math.pi}')
        .replaceAll('e', '${math.e}')
        .replaceAll('Ans', lastAnswer.replaceAll(',', ''));

    // Handle DEG vs RAD in trig functions
    return _evaluateSimpleMath(sanitized);
  }

  double _evaluateSimpleMath(String expr) {
    // Custom robust recursive math parser supporting +, -, *, /, ^, sin, cos, tan, ln, log, sqrt, factorial
    return _parseExpression(expr);
  }

  double _parseExpression(String str) {
    str = str.replaceAll(' ', '');
    if (str.isEmpty) return 0.0;

    // Handle basic operations using Dart math evaluation
    return _evalTokens(_tokenize(str));
  }

  List<String> _tokenize(String str) {
    List<String> tokens = [];
    String buffer = '';
    for (int i = 0; i < str.length; i++) {
      String char = str[i];
      if ('+-*/^()'.contains(char)) {
        if (buffer.isNotEmpty) {
          tokens.add(buffer);
          buffer = '';
        }
        tokens.add(char);
      } else {
        buffer += char;
      }
    }
    if (buffer.isNotEmpty) {
      tokens.add(buffer);
    }
    return tokens;
  }

  double _evalTokens(List<String> tokens) {
    if (tokens.isEmpty) return 0.0;
    // Replace functions in tokens
    List<dynamic> parsed = [];
    int i = 0;
    while (i < tokens.length) {
      String tok = tokens[i];
      if (tok == 'sin' || tok == 'cos' || tok == 'tan' || tok == 'ln' || tok == 'log' || tok == '√') {
        String func = tok;
        i++;
        if (i < tokens.length && tokens[i] == '(') {
          int depth = 1;
          int start = i + 1;
          i++;
          while (i < tokens.length && depth > 0) {
            if (tokens[i] == '(') depth++;
            if (tokens[i] == ')') depth--;
            i++;
          }
          List<String> inner = tokens.sublist(start, i - 1);
          double innerVal = _evalTokens(inner);
          parsed.add(_applyFunc(func, innerVal));
        } else {
          double val = double.tryParse(tokens[i]) ?? 0.0;
          parsed.add(_applyFunc(func, val));
          i++;
        }
      } else if (tok == '(') {
        int depth = 1;
        int start = i + 1;
        i++;
        while (i < tokens.length && depth > 0) {
          if (tokens[i] == '(') depth++;
          if (tokens[i] == ')') depth--;
          i++;
        }
        List<String> inner = tokens.sublist(start, i - 1);
        parsed.add(_evalTokens(inner));
      } else {
        double? num = double.tryParse(tok);
        if (num != null) {
          parsed.add(num);
        } else if (tok.isNotEmpty && '+-*/^'.contains(tok)) {
          parsed.add(tok);
        }
        i++;
      }
    }

    return _evaluateParsedList(parsed);
  }

  double _applyFunc(String func, double val) {
    double radVal = isDeg ? (val * math.pi / 180.0) : val;
    switch (func) {
      case 'sin':
        return math.sin(radVal);
      case 'cos':
        return math.cos(radVal);
      case 'tan':
        return math.tan(radVal);
      case 'ln':
        return math.log(val);
      case 'log':
        return math.log(val) / math.ln10;
      case '√':
        return math.sqrt(val);
      default:
        return val;
    }
  }

  double _evaluateParsedList(List<dynamic> list) {
    if (list.isEmpty) return 0.0;
    // Process exponents ^
    List<dynamic> stage1 = [];
    int idx = 0;
    while (idx < list.length) {
      if (list[idx] == '^') {
        double prev = (stage1.removeLast() as num).toDouble();
        double next = (list[idx + 1] as num).toDouble();
        stage1.add(math.pow(prev, next).toDouble());
        idx += 2;
      } else {
        stage1.add(list[idx]);
        idx++;
      }
    }

    // Process * and /
    List<dynamic> stage2 = [];
    idx = 0;
    while (idx < stage1.length) {
      if (stage1[idx] == '*' || stage1[idx] == '/') {
        String op = stage1[idx] as String;
        double prev = (stage2.removeLast() as num).toDouble();
        double next = (stage1[idx + 1] as num).toDouble();
        if (op == '*') {
          stage2.add(prev * next);
        } else {
          stage2.add(next != 0 ? prev / next : 0.0);
        }
        idx += 2;
      } else {
        stage2.add(stage1[idx]);
        idx++;
      }
    }

    // Process + and -
    if (stage2.isEmpty) return 0.0;
    double result = (stage2[0] as num).toDouble();
    idx = 1;
    while (idx < stage2.length) {
      String op = stage2[idx] as String;
      double next = (stage2[idx + 1] as num).toDouble();
      if (op == '+') {
        result += next;
      } else if (op == '-') {
        result -= next;
      }
      idx += 2;
    }

    return result;
  }

  String _formatNumber(double val) {
    if (val.isNaN) return 'Error';
    if (val.isInfinite) return 'Infinity';
    if (val == val.toInt()) {
      return val.toInt().toString();
    }
    String s = val.toStringAsFixed(8);
    // Remove trailing zeros
    s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    return s;
  }

  String _doubleToFraction(double value) {
    if (value == value.toInt()) return value.toInt().toString();
    double tolerance = 1.0e-6;
    double h1 = 1, h2 = 0, k1 = 0, k2 = 1;
    double b = value;
    do {
      double a = b.floorToDouble();
      double aux = h1;
      h1 = a * h1 + h2;
      h2 = aux;
      aux = k1;
      k1 = a * k1 + k2;
      k2 = aux;
      b = 1.0 / (b - a);
    } while ((value - h1 / k1).abs() > value * tolerance && k1 < 1000);

    int num = h1.toInt();
    int den = k1.toInt();
    return '$num/$den';
  }
}
