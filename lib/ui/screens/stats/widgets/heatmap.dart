import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';

class CustomHeatMap extends StatefulWidget {
  final List<DreamModel> list;
  const CustomHeatMap({super.key, required this.list});

  @override
  State<StatefulWidget> createState() => CustomHeatMapState();
}

class CustomHeatMapState extends State<CustomHeatMap> {
  @override
  Widget build(BuildContext context) {
    final datasets = _countTimestampsByDay(widget.list);
    final defaultColor = Theme.of(context).colorScheme.background;
    final activeColor = Theme.of(context).colorScheme.primary;
    const heatMapfontSize = 16.0;
    var currLocale =
        Provider.of<SettingsProvider>(context, listen: true).locale;

    return HeatMap(
      defaultColor: defaultColor,
      fontSize: heatMapfontSize,
      showColorTip: false,
      scrollable: true,
      locale: currLocale,
      datasets: datasets,
      colorMode: ColorMode.opacity,
      colorsets: {1: activeColor},
    );
  }

  Map<DateTime, int> _countTimestampsByDay(List<DreamModel> items) {
    Map<DateTime, int> counters = {};
    for (var item in items) {
      DateTime timestamp = item.timestamp;
      DateTime dayTimestamp =
          DateTime(timestamp.year, timestamp.month, timestamp.day);
      if (counters.containsKey(dayTimestamp)) {
        counters[dayTimestamp] = (counters[dayTimestamp] ?? 0) + 1;
      } else {
        counters[dayTimestamp] = 1;
      }
    }
    return counters;
  }
}
