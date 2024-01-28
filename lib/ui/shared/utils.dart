import 'dart:async';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/providers/settings_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart'
    show SharePlatform;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Utils {
  String createDateTimeString(
      DateTime datetime, BuildContext context, bool isShort) {
    var currLocale =
        Provider.of<SettingsProvider>(context, listen: false).locale;
    final f =
        DateFormat(isShort ? 'dd / MM /yyyy' : 'dd MMMM yyyy', currLocale);
    return f.format(datetime);
  }

  void customSnackBar(BuildContext ctx, String txt) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(txt)));
  }

  void copyOnClipboard(BuildContext ctx, String text) {
    var label = AppLocalizations.of(ctx)!.copyOnClipboard;
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(label)));
    });
  }

  Map<String, String> getMapEmotions(BuildContext context) {
    return {
      "emotionRage": AppLocalizations.of(context)!.emotionRage,
      "emotionInsecurity": AppLocalizations.of(context)!.emotionInsecurity,
      "emotionShame": AppLocalizations.of(context)!.emotionShame,
      "emotionHappiness": AppLocalizations.of(context)!.emotionHappiness,
      "emotionSatisfaction": AppLocalizations.of(context)!.emotionSatisfaction,
      "emotionWisdom": AppLocalizations.of(context)!.emotionWisdom,
      "emotionGuilt": AppLocalizations.of(context)!.emotionGuilt,
      "emotionDisapproval": AppLocalizations.of(context)!.emotionDisapproval,
      "emotionSexualPleasure":
          AppLocalizations.of(context)!.emotionSexualPleasure,
      "emotionBetrayal": AppLocalizations.of(context)!.emotionBetrayal,
      "emotionSadness": AppLocalizations.of(context)!.emotionSadness,
      "emotionFrustration": AppLocalizations.of(context)!.emotionFrustration,
      "emotionSurprise": AppLocalizations.of(context)!.emotionSurprise,
      "emotionConfusion": AppLocalizations.of(context)!.emotionConfusion,
      "emotionFear": AppLocalizations.of(context)!.emotionFear,
      "emotionAgony": AppLocalizations.of(context)!.emotionAgony,
      "emotionRejection": AppLocalizations.of(context)!.emotionRejection,
      "emotionPanic": AppLocalizations.of(context)!.emotionPanic,
      "emotionPleasure": AppLocalizations.of(context)!.emotionPleasure,
      "emotionFreedom": AppLocalizations.of(context)!.emotionFreedom,
      "emotionEnvy": AppLocalizations.of(context)!.emotionEnvy,
      "emotionJealousy": AppLocalizations.of(context)!.emotionJealousy,
      "emotionAnxiety": AppLocalizations.of(context)!.emotionAnxiety,
      "emotionJoy": AppLocalizations.of(context)!.emotionJoy,
      "emotionLove": AppLocalizations.of(context)!.emotionLove,
    };
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }

  static SharePlatform get _platform => SharePlatform.instance;
  Future<void> shareDream(DreamModel dream, BuildContext context) {
    var title =
        dream.title.isEmpty ? AppLocalizations.of(context)!.dream : dream.title;
    var description = dream.description;
    var analysis = dream.analysis.isEmpty ? "..." : dream.analysis;
    var emotions = dream.emotions.isEmpty ? "" : dream.emotions.toString();
    var notes = dream.notes.isEmpty
        ? ""
        : "[${AppLocalizations.of(context)!.notes}] \n${dream.notes}";
    var timestamp = createDateTimeString(dream.timestamp, context, false);

    var l = [];
    if (dream.nightmare) l.add(AppLocalizations.of(context)!.nightmare);
    if (dream.recurrent) l.add(AppLocalizations.of(context)!.recurrent);
    var options = l.isNotEmpty ? l : "";

    var text = '''
$timestamp
[$title]
$description
$emotions

[${AppLocalizations.of(context)!.analisys}]
$analysis

$notes
$options''';
    assert(text.isNotEmpty);
    return _platform.share(text);
  }
}
