import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../services/calculator_engine.dart';
import '../models/tape_entry.dart';

class CalculatorScreen extends StatefulWidget {
  final CalculatorEngine engine;
  final Function(TapeEntry) onNewTapeEntry;

  const CalculatorScreen({
    super.key,
    required this.engine,
    required this.onNewTapeEntry,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  bool isSciDeckExpanded = true;

  void _onKeyPress(String key) {
    HapticFeedback.lightImpact();
    setState(() {
      if (key == 'AC') {
        widget.engine.clearAll();
      } else if (key == 'DEL') {
        widget.engine.deleteLast();
      } else if (key == '=') {
        String prevExpr = widget.engine.expression;
        widget.engine.evaluate();
        if (prevExpr.isNotEmpty) {
          widget.onNewTapeEntry(
            TapeEntry(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: 'Calculation',
              expression: prevExpr,
              result: widget.engine.evaluatedResult,
              timestamp: 'Just now',
              category: 'general',
            ),
          );
        }
      } else if (key == 'MC') {
        widget.engine.memoryClear();
      } else if (key == 'MR') {
        widget.engine.memoryRecall();
      } else if (key == 'M+') {
        widget.engine.memoryAdd();
      } else if (key == 'M-') {
        widget.engine.memorySubtract();
      } else {
        widget.engine.append(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Milled Obsidian Display Vane
        _buildDisplayVane(),

        const SizedBox(height: 8),

        // 2. Mode Ribbon & Memory Strip
        _buildModeRibbon(),

        const SizedBox(height: 8),

        // 3. Collapsible Scientific Deck
        if (isSciDeckExpanded) _buildScientificDeck(),

        const SizedBox(height: 8),

        // 4. Primary Numeric & Operator Keypad
        Expanded(child: _buildKeypad()),
      ],
    );
  }

  Widget _buildDisplayVane() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha:0.06),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row 1: History Stack & Angle Mode Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.history, size: 14, color: AppColors.primaryFixedDim),
                  const SizedBox(width: 4),
                  Text(
                    'Ans = ${widget.engine.lastAnswer}',
                    style: AppTypography.keypadScientific.copyWith(color: AppColors.outline),
                  ),
                  if (widget.engine.memoryValue != 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'M ${widget.engine.memoryValue}',
                        style: AppTypography.labelCaps.copyWith(
                          fontSize: 9,
                          color: AppColors.primaryContainer,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.engine.toggleAngleMode();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.engine.isDeg ? AppColors.primaryContainer : AppColors.outline,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.engine.isDeg ? 'DEG' : 'RAD',
                            style: AppTypography.labelCaps.copyWith(
                              color: AppColors.primaryFixed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 16, color: AppColors.outline),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.engine.evaluatedResult));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Result copied to clipboard!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Row 2: Live Expression Input
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.engine.expression.isEmpty ? '0' : widget.engine.expression,
                  style: AppTypography.displayExpression,
                ),
                Container(
                  width: 2,
                  height: 20,
                  margin: const EdgeInsets.only(left: 4),
                  color: AppColors.primaryContainer,
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // Row 3: Real-Time Preview
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '≈ ${widget.engine.livePreview}',
              style: AppTypography.bodyCompact.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ),

          const SizedBox(height: 12),

          // Row 4: Evaluated Answer Viewport
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow.withValues(alpha:0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Fraction toggle button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.engine.toggleFraction();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.engine.isFractionMode ? AppColors.primaryContainer : AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'a b/c ↔ d/e',
                      style: AppTypography.labelCaps.copyWith(
                        fontSize: 10,
                        color: widget.engine.isFractionMode ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      widget.engine.evaluatedResult,
                      style: AppTypography.displayResultMobile,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeRibbon() {
    return Row(
      children: [
        _buildPillButton('2nd', isSelected: widget.engine.is2nd, onTap: () {
          setState(() {
            widget.engine.toggle2nd();
          });
        }),
        const SizedBox(width: 4),
        _buildPillButton('HYP', isSelected: widget.engine.isHyp, onTap: () {
          setState(() {
            widget.engine.toggleHyp();
          });
        }),
        const SizedBox(width: 8),
        _buildPillButton('MC', onTap: () => _onKeyPress('MC')),
        const SizedBox(width: 4),
        _buildPillButton('MR', onTap: () => _onKeyPress('MR')),
        const SizedBox(width: 4),
        _buildPillButton('M+', textColor: AppColors.primaryFixedDim, onTap: () => _onKeyPress('M+')),
        const SizedBox(width: 4),
        _buildPillButton('M-', textColor: AppColors.secondary, onTap: () => _onKeyPress('M-')),
        const Spacer(),
        GestureDetector(
          onTap: () {
            setState(() {
              isSciDeckExpanded = !isSciDeckExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isSciDeckExpanded ? Icons.unfold_less : Icons.unfold_more,
                  size: 16,
                  color: AppColors.primaryContainer,
                ),
                const SizedBox(width: 4),
                Text(
                  isSciDeckExpanded ? 'ADV' : 'EXPAND',
                  style: AppTypography.labelCaps.copyWith(color: AppColors.primaryContainer),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPillButton(String label, {bool isSelected = false, Color? textColor, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: AppTypography.labelCaps.copyWith(
            color: isSelected
                ? AppColors.onPrimaryContainer
                : (textColor ?? AppColors.onSurfaceVariant),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildScientificDeck() {
    List<List<String>> rows = [
      ['sin', 'cos', 'tan', 'ln', 'log', '^'],
      ['√', 'x²', 'π', 'e', '(', ')'],
    ];

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: row.map((key) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: GestureDetector(
                    onTap: () {
                      if (key == 'sin') {
                        _onKeyPress('sin(');
                      } else if (key == 'cos') {
                        _onKeyPress('cos(');
                      } else if (key == 'tan') {
                        _onKeyPress('tan(');
                      } else if (key == 'ln') {
                        _onKeyPress('ln(');
                      } else if (key == 'log') {
                        _onKeyPress('log(');
                      } else if (key == '√') {
                        _onKeyPress('√(');
                      } else if (key == 'x²') {
                        _onKeyPress('^2');
                      } else {
                        _onKeyPress(key);
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withValues(alpha:0.04)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        key,
                        style: AppTypography.keypadScientific.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeypad() {
    List<List<String>> keypad = [
      ['AC', 'DEL', '^', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '−'],
      ['1', '2', '3', '+'],
      ['0', '.', 'Ans', '='],
    ];

    return Column(
      children: keypad.map((row) {
        return Expanded(
          child: Row(
            children: row.map((btn) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: _buildKeyButton(btn),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeyButton(String label) {
    bool isOperator = label == '+' || label == '−' || label == '×' || label == '÷';
    bool isClear = label == 'AC' || label == 'DEL';
    bool isEquals = label == '=';

    Color bgColor = AppColors.keyNumericBg;
    Color textColor = AppColors.keyNumericText;

    if (isOperator) {
      bgColor = AppColors.surfaceContainerLow;
      textColor = AppColors.amberCoral;
    } else if (isClear) {
      bgColor = AppColors.secondaryContainer.withValues(alpha:0.3);
      textColor = AppColors.amberCoral;
    } else if (isEquals) {
      bgColor = AppColors.primaryContainer;
      textColor = AppColors.onPrimaryContainer;
    }

    return GestureDetector(
      onTap: () => _onKeyPress(label),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isEquals
              ? [
                  BoxShadow(
                    color: AppColors.primaryContainer.withValues(alpha:0.4),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.4),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
          border: Border.all(
            color: isEquals
                ? AppColors.primaryContainer
                : Colors.white.withValues(alpha:0.06),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: isOperator
              ? AppTypography.keypadOperator
              : (isEquals
                  ? AppTypography.keypadNumber.copyWith(
                      color: AppColors.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    )
                  : AppTypography.keypadNumber.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
