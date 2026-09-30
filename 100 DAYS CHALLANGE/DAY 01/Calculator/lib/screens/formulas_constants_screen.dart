import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../models/constant_item.dart';

class FormulasConstantsScreen extends StatefulWidget {
  final Function(String) onInsertIntoCalc;

  const FormulasConstantsScreen({
    super.key,
    required this.onInsertIntoCalc,
  });

  @override
  State<FormulasConstantsScreen> createState() => _FormulasConstantsScreenState();
}

class _FormulasConstantsScreenState extends State<FormulasConstantsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = '';

  static const List<ConstantItem> constantsList = [
    ConstantItem(
      symbol: 'h',
      name: 'Planck Constant',
      value: '6.62607015e-34',
      formattedValue: '6.62607 × 10⁻³⁴',
      unit: 'J·s',
      category: 'Quantum Physics',
    ),
    ConstantItem(
      symbol: 'c',
      name: 'Speed of Light',
      value: '299792458',
      formattedValue: '299,792,458',
      unit: 'm·s⁻¹',
      category: 'Relativity',
    ),
    ConstantItem(
      symbol: 'G',
      name: 'Gravitational Constant',
      value: '6.67430e-11',
      formattedValue: '6.67430 × 10⁻¹¹',
      unit: 'N·m²·kg⁻²',
      category: 'Astrophysics',
    ),
    ConstantItem(
      symbol: 'e',
      name: "Euler's Number",
      value: '2.718281828459045',
      formattedValue: '2.718281828...',
      unit: 'Scalar',
      category: 'Math Constants',
    ),
    ConstantItem(
      symbol: 'π',
      name: 'Pi',
      value: '3.141592653589793',
      formattedValue: '3.141592653...',
      unit: 'Scalar',
      category: 'Math Constants',
    ),
    ConstantItem(
      symbol: 'NA',
      name: "Avogadro's Number",
      value: '6.02214076e23',
      formattedValue: '6.02214 × 10²³',
      unit: 'mol⁻¹',
      category: 'Thermodynamics',
    ),
    ConstantItem(
      symbol: 'e⁻',
      name: 'Elementary Charge',
      value: '1.602176634e-19',
      formattedValue: '1.60217 × 10⁻¹⁹',
      unit: 'Coulombs (C)',
      category: 'Electromagnetism',
    ),
    ConstantItem(
      symbol: 'kB',
      name: 'Boltzmann Constant',
      value: '1.380649e-23',
      formattedValue: '1.380649 × 10⁻²³',
      unit: 'J·K⁻¹',
      category: 'Thermodynamics',
    ),
  ];

  static const List<FormulaItem> formulasList = [
    FormulaItem(
      title: 'Kinetic Energy',
      category: 'Classical Mechanics',
      formula: '0.5 × m × v²',
      description: 'Energy possessed by an object due to its motion.',
      variables: ['m = mass (kg)', 'v = velocity (m/s)'],
    ),
    FormulaItem(
      title: 'Quadratic Formula',
      category: 'Algebra',
      formula: '(-b ± √(b² - 4×a×c)) / (2×a)',
      description: 'Solutions for ax² + bx + c = 0.',
      variables: ['a, b, c = coefficients'],
    ),
    FormulaItem(
      title: 'Euler Identity',
      category: 'Complex Analysis',
      formula: 'e^(i×π) + 1 = 0',
      description: 'Connects five fundamental mathematical constants.',
      variables: ['e, i, π'],
    ),
    FormulaItem(
      title: 'Ideal Gas Law',
      category: 'Thermodynamics',
      formula: 'P × V = n × R × T',
      description: 'Equation of state of a hypothetical ideal gas.',
      variables: ['P = pressure', 'V = volume', 'n = moles', 'R = gas const', 'T = temp'],
    ),
    FormulaItem(
      title: 'Time Dilation',
      category: 'Relativity',
      formula: 't / √(1 - (v²/c²))',
      description: 'Difference in elapsed time measured by observers.',
      variables: ['t = proper time', 'v = relative velocity', 'c = speed of light'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sub Header
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.functions, color: AppColors.primaryContainer, size: 20),
                  const SizedBox(width: 8),
                  Text('Formulas & Constants', style: AppTypography.headlineSheet.copyWith(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (val) {
                  setState(() {
                    searchQuery = val;
                  });
                },
                style: AppTypography.bodyRegular,
                decoration: InputDecoration(
                  hintText: 'Search constants or formulas...',
                  hintStyle: AppTypography.bodyRegular.copyWith(color: AppColors.outline),
                  prefixIcon: const Icon(Icons.search, color: AppColors.outline),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLowest,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primaryContainer,
                labelColor: AppColors.primaryContainer,
                unselectedLabelColor: AppColors.onSurfaceVariant,
                tabs: const [
                  Tab(text: 'PHYSICAL CONSTANTS'),
                  Tab(text: 'FORMULA LIBRARY'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildConstantsGrid(),
              _buildFormulasList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConstantsGrid() {
    List<ConstantItem> filtered = constantsList.where((c) {
      if (searchQuery.isEmpty) return true;
      String q = searchQuery.toLowerCase();
      return c.name.toLowerCase().contains(q) || c.symbol.toLowerCase().contains(q) || c.category.toLowerCase().contains(q);
    }).toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        ConstantItem item = filtered[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha:0.04)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.symbol,
                    style: AppTypography.keypadNumber.copyWith(
                      color: AppColors.primaryFixed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => widget.onInsertIntoCalc(item.value),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfaceContainerHighest,
                      foregroundColor: AppColors.primaryContainer,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text('INSERT', style: AppTypography.labelCaps.copyWith(fontSize: 9, color: AppColors.primaryContainer)),
                  ),
                ],
              ),
              Text(item.name, style: AppTypography.bodyCompact.copyWith(color: AppColors.outline)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.formattedValue, style: AppTypography.bodyRegular.copyWith(fontWeight: FontWeight.bold)),
                  Text(item.unit, style: AppTypography.labelCaps.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormulasList() {
    List<FormulaItem> filtered = formulasList.where((f) {
      if (searchQuery.isEmpty) return true;
      String q = searchQuery.toLowerCase();
      return f.title.toLowerCase().contains(q) || f.formula.toLowerCase().contains(q) || f.category.toLowerCase().contains(q);
    }).toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        FormulaItem item = filtered[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha:0.04)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.title, style: AppTypography.bodyRegular.copyWith(fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.category.toUpperCase(),
                      style: AppTypography.labelCaps.copyWith(fontSize: 9, color: AppColors.primaryFixedDim),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.formula,
                  style: AppTypography.displayExpression.copyWith(fontSize: 16, color: AppColors.primaryContainer),
                ),
              ),
              const SizedBox(height: 8),
              Text(item.description, style: AppTypography.bodyCompact),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.variables.join('  •  '), style: AppTypography.labelCaps.copyWith(fontSize: 10, color: AppColors.outline)),
                  ElevatedButton.icon(
                    onPressed: () => widget.onInsertIntoCalc(item.formula),
                    icon: const Icon(Icons.input, size: 14, color: AppColors.onPrimaryContainer),
                    label: const Text('Insert Formula', style: TextStyle(color: AppColors.onPrimaryContainer, fontSize: 11)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
