import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../services/unit_converter_service.dart';

class UnitConverterScreen extends StatefulWidget {
  final Function(String) onSendToCalc;

  const UnitConverterScreen({
    super.key,
    required this.onSendToCalc,
  });

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  String selectedCategory = 'Length';
  late String fromUnit;
  late String toUnit;
  double inputValue = 1250.0;
  TextEditingController inputController = TextEditingController(text: '1250');

  @override
  void initState() {
    super.initState();
    _resetUnits();
  }

  void _resetUnits() {
    List<String> units = UnitConverterService.unitsByCategory[selectedCategory] ?? [];
    fromUnit = units.isNotEmpty ? units[0] : '';
    toUnit = units.length > 1 ? units[4] : (units.isNotEmpty ? units[0] : '');
  }

  void _swapUnits() {
    setState(() {
      String temp = fromUnit;
      fromUnit = toUnit;
      toUnit = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double convertedResult = UnitConverterService.convert(
      category: selectedCategory,
      fromUnit: fromUnit,
      toUnit: toUnit,
      value: inputValue,
    );

    Map<String, String> cascade = UnitConverterService.getCascadeEquivalents(
      selectedCategory,
      fromUnit,
      inputValue,
    );

    return Column(
      children: [
        // Sub Header & Category Selector
        _buildCategorySelector(),

        const SizedBox(height: 12),

        // Conversion Source & Target Cards
        _buildConversionCards(convertedResult),

        const SizedBox(height: 12),

        // Quick Actions Ribbon
        _buildActionRibbon(convertedResult),

        const SizedBox(height: 16),

        // Live Cascade Multi-Scale Equivalents Grid
        Expanded(child: _buildCascadeGrid(cascade)),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.swap_horiz, color: AppColors.primaryContainer, size: 20),
              const SizedBox(width: 8),
              Text('Unit Converter', style: AppTypography.headlineSheet.copyWith(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: UnitConverterService.categories.map((cat) {
                bool isSel = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSel,
                    selectedColor: AppColors.primaryContainer,
                    backgroundColor: AppColors.surfaceContainer,
                    labelStyle: AppTypography.labelCaps.copyWith(
                      color: isSel ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (val) {
                      setState(() {
                        selectedCategory = cat;
                        _resetUnits();
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionCards(double convertedResult) {
    List<String> units = UnitConverterService.unitsByCategory[selectedCategory] ?? [];

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            // 'From' Source Card
            Container(
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
                      Text('SOURCE DIMENSION', style: AppTypography.labelCaps.copyWith(color: AppColors.primaryContainer)),
                      DropdownButton<String>(
                        value: fromUnit,
                        dropdownColor: AppColors.surfaceContainerHigh,
                        underline: const SizedBox(),
                        style: AppTypography.bodyRegular,
                        items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              fromUnit = val;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    style: AppTypography.displayResultMobile.copyWith(color: AppColors.primary),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (val) {
                      setState(() {
                        inputValue = double.tryParse(val) ?? 0.0;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 'To' Target Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha:0.04)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TARGET DIMENSION', style: AppTypography.labelCaps.copyWith(color: AppColors.secondary)),
                      DropdownButton<String>(
                        value: toUnit,
                        dropdownColor: AppColors.surfaceContainerHigh,
                        underline: const SizedBox(),
                        style: AppTypography.bodyRegular,
                        items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              toUnit = val;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatResult(convertedResult),
                    style: AppTypography.displayResultMobile.copyWith(color: AppColors.secondary),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Direction Inverter Pivot Button
        FloatingActionButton.small(
          onPressed: _swapUnits,
          backgroundColor: AppColors.surfaceContainerHighest,
          child: const Icon(Icons.swap_vert, color: AppColors.primaryContainer),
        ),
      ],
    );
  }

  Widget _buildActionRibbon(double convertedResult) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _formatResult(convertedResult)));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Result copied to clipboard!'), duration: Duration(seconds: 1)),
              );
            },
            icon: const Icon(Icons.copy, size: 16, color: AppColors.primaryContainer),
            label: const Text('COPY', style: TextStyle(color: AppColors.onSurface)),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.surfaceContainerLow),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => widget.onSendToCalc(_formatResult(convertedResult)),
            icon: const Icon(Icons.send_to_mobile, size: 16, color: AppColors.onPrimaryContainer),
            label: const Text('TO CALC', style: TextStyle(color: AppColors.onPrimaryContainer)),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryContainer),
          ),
        ),
      ],
    );
  }

  Widget _buildCascadeGrid(Map<String, String> cascade) {
    List<MapEntry<String, String>> items = cascade.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('MULTI-SCALE EQUIVALENTS', style: AppTypography.labelCaps),
            Text('LIVE CASCADE', style: AppTypography.labelCaps.copyWith(color: AppColors.primaryFixedDim)),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              var entry = items[index];
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(entry.key, style: AppTypography.bodyCompact),
                    const SizedBox(height: 4),
                    Text(entry.value, style: AppTypography.bodyRegular.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatResult(double val) {
    if (val == val.toInt()) return val.toInt().toString();
    if (val > 100000 || (val < 0.0001 && val > 0)) {
      return val.toStringAsExponential(4);
    }
    String s = val.toStringAsFixed(4);
    return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}
