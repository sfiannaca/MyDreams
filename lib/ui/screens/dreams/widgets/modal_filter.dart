import 'package:diaryofdreams/models/filter_model.dart';
import 'package:diaryofdreams/providers/filter_provider.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/dreams/widgets/multi_select_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const customTextStyles = Styles.filtersTextStyle;

class ModalFilter extends StatelessWidget {
  const ModalFilter({
    super.key,
    required this.context,
  });

  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    const containerPadding = EdgeInsets.all(12);
    const modalSpacing = 40.0;
    final filters = Provider.of<FilterProvider>(context, listen: false).filters;
    const labelsFormStyle = Styles.labelsTextStyle;

    return Scaffold(
        body: Padding(
      padding: containerPadding,
      child: ListView(children: [
        ListTile(
            title: Text(AppLocalizations.of(context)!.filters,
                style: labelsFormStyle),
            trailing: IconButton(
                icon: const Icon(
                  Icons.filter_list_off,
                  color: Colors.red,
                ),
                onPressed: () => resetFilter(context, filters))),
        const SizedBox(height: modalSpacing),
        _buildTagButton(isDarkMode, filters),
        const SizedBox(height: modalSpacing / 2),
        _buildStaredButton(isDarkMode, filters),
        const SizedBox(height: modalSpacing / 2),
        _buildAnalisysButton(isDarkMode, filters),
        const SizedBox(height: modalSpacing),
        _buildEmotionsFilter(filters),
      ]),
    ));
  }

  Widget _buildAnalisysButton(bool isDarkMode, FilterModel filters) {
    final labels = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.notInterpreted
    ];

    final activeBgColor = [Styles.seedColor];

    final totalSwitches = labels.length;
    int? selectedAnalysisIndex;
    selectedAnalysisIndex = filters.onlyEmptyAnalisys == true ? 1 : 0;

    void updateEmptyAnalisysFilter(int? index) {
      switch (index) {
        case 0:
          // all
          Provider.of<FilterProvider>(context, listen: false)
              .onlyEmptyAnalisys(false);
          break;
        case 1:
          // onlyEmptyAnalisys
          Provider.of<FilterProvider>(context, listen: false)
              .onlyEmptyAnalisys(true);
          break;
      }
    }

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        ToggleSwitch(
            minWidth: double.infinity,
            minHeight: 40.0,
            initialLabelIndex: selectedAnalysisIndex,
            totalSwitches: totalSwitches,
            activeBgColor: activeBgColor,
            customTextStyles: customTextStyles,
            inactiveBgColor: Theme.of(context).brightness == Brightness.dark
                ? Styles.customBgCards
                : Theme.of(context).colorScheme.secondary,
            labels: labels,
            onToggle: (index) {
              if (index == selectedAnalysisIndex) return;
              updateEmptyAnalisysFilter(index);
            }),
      ],
    );
  }

  Widget _buildTagButton(bool isDarkMode, FilterModel filters) {
    final labels = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.recurrent,
      AppLocalizations.of(context)!.nightmare,
    ];
    final activeBgColor = [Styles.seedColor];
    final totalSwitches = labels.length;
    int? selectedTagIndex;
    if (filters.onlyNightmare != null || filters.onlyRecurrent != null) {
      selectedTagIndex = filters.onlyRecurrent == true ? 1 : 2;
    } else {
      selectedTagIndex = 0;
    }

    void updateTagsFilter(int? index) {
      switch (index) {
        case 0:
          // all
          Provider.of<FilterProvider>(context, listen: false)
              .onlyNightmare(null);
          Provider.of<FilterProvider>(context, listen: false)
              .onlyRecurrent(null);
          break;
        case 1:
          // recurrent
          Provider.of<FilterProvider>(context, listen: false)
              .onlyNightmare(null);
          Provider.of<FilterProvider>(context, listen: false)
              .onlyRecurrent(true);
          break;
        case 2:
          // nightmare
          Provider.of<FilterProvider>(context, listen: false)
              .onlyNightmare(true);
          Provider.of<FilterProvider>(context, listen: false)
              .onlyRecurrent(null);
          break;

        default:
      }
    }

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        ToggleSwitch(
            minWidth: double.infinity,
            minHeight: 40.0,
            initialLabelIndex: selectedTagIndex,
            totalSwitches: totalSwitches,
            activeBgColor: activeBgColor,
            inactiveBgColor: Theme.of(context).brightness == Brightness.dark
                ? Styles.customBgCards
                : Theme.of(context).colorScheme.secondary,
            customTextStyles: customTextStyles,
            labels: labels,
            onToggle: (index) {
              if (index == selectedTagIndex) return;
              updateTagsFilter(index);
            }),
      ],
    );
  }

  Widget _buildStaredButton(bool isDarkMode, FilterModel filters) {
    final labels = [AppLocalizations.of(context)!.all, '', ""];
    final iconLabels = [
      null,
      const Icon(
        Icons.star_rate,
        color: Colors.amber,
      ),
      const Icon(
        Icons.star_border,
        color: Colors.white,
      )
    ];
    final activeBgColor = [Styles.seedColor];
    final totalSwitches = labels.length;
    int? selectedIndex;
    if (filters.onlyStared == null) {
      selectedIndex = null;
    } else {
      selectedIndex = filters.onlyStared == true ? 1 : 2;
    }

    void updateStaredFilter(int? index) {
      bool? value;
      switch (index) {
        case 0:
          value = null;
          break;
        case 1:
          value = true;
          break;
        case 2:
          value = false;
          break;
        default:
      }

      Provider.of<FilterProvider>(context, listen: false).onlyStared(value);
    }

    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        ToggleSwitch(
            minWidth: double.infinity,
            minHeight: 40.0,
            customIcons: iconLabels,
            initialLabelIndex: selectedIndex ?? 0,
            totalSwitches: totalSwitches,
            activeBgColor: activeBgColor,
            inactiveBgColor: Theme.of(context).brightness == Brightness.dark
                ? Styles.customBgCards
                : Theme.of(context).colorScheme.secondary,
            customTextStyles: customTextStyles,
            labels: labels,
            onToggle: (index) {
              updateStaredFilter(index);
            }),
      ],
    );
  }

  Widget _buildEmotionsFilter(FilterModel filters) {
    return MultiSelectChip(
      selectedItem: filters.byEmotions,
      isUsedByFilter: true,
    );
  }

  void resetFilter(BuildContext ctx, FilterModel filters) {
    Provider.of<FilterProvider>(context, listen: false).resetValues();
    Navigator.of(ctx).pop();
  }
}
