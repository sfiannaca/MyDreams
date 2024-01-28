import 'package:diaryofdreams/providers/filter_provider.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultiSelectChip extends StatefulWidget {
  const MultiSelectChip({
    super.key,
    required this.selectedItem,
    required this.isUsedByFilter,
  });

  final List<String> selectedItem;
  final bool isUsedByFilter;

  @override
  State<MultiSelectChip> createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  @override
  Widget build(BuildContext context) {
    var selectedItem = widget.selectedItem;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var map = Utils().getMapEmotions(context);
    const kInactiveLightColor = Styles.seedColor;
    const chipsFontSize = 16.0;
    const kInActiveColor = Styles.customDarkCards;
    final kActiveColor = Theme.of(context).colorScheme.primary;
    final kActiveLightColor = Theme.of(context).colorScheme.secondary;
    const kTextDarkColor = Colors.white;

    return Center(
      child: Wrap(
        children: map.keys.map((item) {
          bool isSelected = selectedItem.contains(item);

          Color backgroundColor = isDarkMode
              ? (isSelected ? kInactiveLightColor : kInActiveColor)
              : (isSelected ? kActiveColor : kActiveLightColor);
          Color textColor = isDarkMode
              ? (isSelected ? kTextDarkColor : Colors.white)
              : (isSelected ? Colors.white : Colors.white);

          String? translatedText = map[item];

          return GestureDetector(
            onTap: () => _onChipTapped(item, selectedItem, map.keys),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                child: Text(
                  translatedText!,
                  style: TextStyle(color: textColor, fontSize: chipsFontSize),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _onChipTapped(String item, List<String> items, Iterable<String> keys) {
    setState(() {
      if (widget.isUsedByFilter) return _onTapFilterChips(item);

      if (!items.contains(item)) {
        if (items.length < keys.length) items.add(item);
      } else {
        items.removeWhere((element) => element == item);
      }
    });
  }

  void _onTapFilterChips(String item) {
    setState(() {
      Provider.of<FilterProvider>(context, listen: false)
          .updateByEmotions(item);
    });
  }
}
