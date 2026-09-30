import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../services/calculator_engine.dart';
import '../models/tape_entry.dart';
import 'calculator_screen.dart';
import 'history_tape_screen.dart';
import 'formulas_constants_screen.dart';
import 'unit_converter_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  final CalculatorEngine _calculatorEngine = CalculatorEngine();

  final List<TapeEntry> _tapeEntries = [
    TapeEntry(
      id: 'tape-01',
      title: 'Orbital Velocity',
      expression: '√( (6.674×10⁻¹¹) × (5.972×10²⁴) / (6.371×10⁶ + 400×10³) )',
      result: '7,672.48',
      timestamp: '12:42 PM',
      category: 'physics',
      unit: 'm/s',
      note: 'Low Earth Orbit (LEO @ 400km altitude)',
      isStarred: true,
    ),
    TapeEntry(
      id: 'tape-02',
      title: 'Trig Identity Verification',
      expression: 'sin²(π/3) + cos²(π/3)',
      result: '1.00000',
      timestamp: '2 mins ago',
      category: 'trig',
      isStarred: false,
    ),
    TapeEntry(
      id: 'tape-03',
      title: 'Photon Energy',
      expression: '(6.626×10⁻³⁴) × (3×10⁸) / (500×10⁻⁹)',
      result: '3.9756e-19',
      timestamp: '1 hour ago',
      category: 'physics',
      unit: 'J',
      isStarred: true,
    ),
  ];

  void _onInsertIntoCalc(String value) {
    setState(() {
      _calculatorEngine.append(value);
      _selectedIndex = 0; // Switch tab to Calculator
    });
  }

  void _onClearTape() {
    setState(() {
      _tapeEntries.clear();
    });
  }

  void _onNewTapeEntry(TapeEntry entry) {
    setState(() {
      _tapeEntries.insert(0, entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      CalculatorScreen(
        engine: _calculatorEngine,
        onNewTapeEntry: _onNewTapeEntry,
      ),
      HistoryTapeScreen(
        tapeEntries: _tapeEntries,
        onInsertIntoCalc: _onInsertIntoCalc,
        onClearAll: _onClearTape,
      ),
      FormulasConstantsScreen(
        onInsertIntoCalc: _onInsertIntoCalc,
      ),
      UnitConverterScreen(
        onSendToCalc: _onInsertIntoCalc,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: AppColors.surfaceContainerLowest,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'N',
                          style: TextStyle(
                            color: AppColors.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('NOVA CALC', style: AppTypography.headlineSheet.copyWith(fontSize: 14, color: AppColors.primaryFixed)),
                        Row(
                          children: [
                            Text(
                              _calculatorEngine.isDeg ? 'RAD' : 'DEG',
                              style: AppTypography.labelCaps.copyWith(fontSize: 8, color: AppColors.primaryContainer),
                            ),
                            const SizedBox(width: 4),
                            Text('FLOAT', style: AppTypography.labelCaps.copyWith(fontSize: 8, color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.receipt_long, color: AppColors.onSurfaceVariant, size: 20),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 1; // Tape tab
                        });
                      },
                    ),
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primaryContainer,
                      child: Icon(Icons.person, size: 16, color: AppColors.onPrimaryContainer),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: IndexedStack(
            index: _selectedIndex,
            children: screens,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppColors.surfaceContainerLowest,
        selectedItemColor: AppColors.primaryContainer,
        unselectedItemColor: AppColors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTypography.labelCaps.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: AppTypography.labelCaps,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Tape',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.functions),
            label: 'Formulas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Convert',
          ),
        ],
      ),
    );
  }
}
