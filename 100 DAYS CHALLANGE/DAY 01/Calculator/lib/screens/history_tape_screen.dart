import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../models/tape_entry.dart';

class HistoryTapeScreen extends StatefulWidget {
  final List<TapeEntry> tapeEntries;
  final Function(String) onInsertIntoCalc;
  final VoidCallback onClearAll;

  const HistoryTapeScreen({
    super.key,
    required this.tapeEntries,
    required this.onInsertIntoCalc,
    required this.onClearAll,
  });

  @override
  State<HistoryTapeScreen> createState() => _HistoryTapeScreenState();
}

class _HistoryTapeScreenState extends State<HistoryTapeScreen> {
  String selectedFilter = 'all';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<TapeEntry> filtered = widget.tapeEntries.where((entry) {
      if (selectedFilter == 'starred' && !entry.isStarred) return false;
      if (selectedFilter == 'trig' && entry.category != 'trig') return false;
      if (selectedFilter == 'physics' && entry.category != 'physics') return false;
      if (selectedFilter == 'calculus' && entry.category != 'calculus') return false;

      if (searchQuery.isNotEmpty) {
        String q = searchQuery.toLowerCase();
        bool matchTitle = entry.title.toLowerCase().contains(q);
        bool matchExpr = entry.expression.toLowerCase().contains(q);
        bool matchResult = entry.result.toLowerCase().contains(q);
        return matchTitle || matchExpr || matchResult;
      }
      return true;
    }).toList();

    return Column(
      children: [
        // Sub Header & Search Bar
        _buildHeaderControls(),

        const SizedBox(height: 12),

        // Filter Category Chips
        _buildFilterChips(),

        const SizedBox(height: 12),

        // History Stream List
        Expanded(
          child: filtered.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return _buildTapeCard(filtered[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildHeaderControls() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.receipt_long, color: AppColors.primaryContainer, size: 20),
                  const SizedBox(width: 8),
                  Text('Calculation Tape', style: AppTypography.headlineSheet.copyWith(fontSize: 18)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${widget.tapeEntries.length} entries',
                      style: AppTypography.labelCaps.copyWith(color: AppColors.primaryFixedDim),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: widget.onClearAll,
                icon: const Icon(Icons.delete_sweep, size: 16, color: AppColors.secondary),
                label: const Text('Purge', style: TextStyle(color: AppColors.secondary)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryContainer.withValues(alpha:0.3),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
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
              hintText: 'Search expression, tags or numeric results...',
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
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    List<Map<String, String>> chips = [
      {'id': 'all', 'label': 'ALL (${widget.tapeEntries.length})'},
      {'id': 'starred', 'label': '★ BOOKMARKED'},
      {'id': 'trig', 'label': 'TRIGONOMETRY'},
      {'id': 'calculus', 'label': 'CALCULUS'},
      {'id': 'physics', 'label': 'PHYSICS'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.map((c) {
          bool isActive = selectedFilter == c['id'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(c['label']!),
              selected: isActive,
              selectedColor: AppColors.primaryContainer,
              backgroundColor: AppColors.surfaceContainer,
              labelStyle: AppTypography.labelCaps.copyWith(
                color: isActive ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
              onSelected: (val) {
                setState(() {
                  selectedFilter = c['id']!;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTapeCard(TapeEntry entry) {
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      entry.isStarred ? Icons.star : Icons.star_border,
                      color: entry.isStarred ? AppColors.primaryContainer : AppColors.outline,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        entry.isStarred = !entry.isStarred;
                      });
                    },
                  ),
                  Text(entry.title, style: AppTypography.bodyRegular.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      entry.category.toUpperCase(),
                      style: AppTypography.labelCaps.copyWith(fontSize: 9, color: AppColors.primaryFixedDim),
                    ),
                  ),
                ],
              ),
              Text(entry.timestamp, style: AppTypography.bodyCompact),
            ],
          ),

          const SizedBox(height: 8),

          // Expression Slot
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              entry.expression,
              style: AppTypography.displayExpression.copyWith(fontSize: 16),
            ),
          ),

          const SizedBox(height: 8),

          // Result Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('RESULT', style: AppTypography.labelCaps.copyWith(color: AppColors.primaryContainer)),
              Text(
                '${entry.result} ${entry.unit ?? ''}',
                style: AppTypography.displayResultMobile.copyWith(fontSize: 24, color: AppColors.primaryFixed),
              ),
            ],
          ),

          if (entry.note != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.speed, size: 14, color: AppColors.primaryFixedDim),
                const SizedBox(width: 4),
                Text(entry.note!, style: AppTypography.bodyCompact),
              ],
            ),
          ],

          const SizedBox(height: 12),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () => widget.onInsertIntoCalc(entry.expression),
                icon: const Icon(Icons.input, size: 16, color: AppColors.onPrimaryContainer),
                label: const Text('Insert in Calc', style: TextStyle(color: AppColors.onPrimaryContainer)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  elevation: 0,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18, color: AppColors.primaryFixedDim),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: entry.result));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Result copied to clipboard!'), duration: Duration(seconds: 1)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history, size: 48, color: AppColors.outline),
          const SizedBox(height: 12),
          Text('No history entries yet', style: AppTypography.headlineSheet),
          const SizedBox(height: 4),
          Text('Evaluated calculations will appear here.', style: AppTypography.bodyCompact),
        ],
      ),
    );
  }
}
