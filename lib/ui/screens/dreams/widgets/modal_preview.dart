import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/dreams/edit_screen.dart';
import 'package:diaryofdreams/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModalPreview extends StatefulWidget {
  const ModalPreview({super.key, required this.context, required this.item});

  final BuildContext context;
  final DreamModel item;

  @override
  State<ModalPreview> createState() => _ModalPreviewState();
}

class _ModalPreviewState extends State<ModalPreview> {
  void _goToEdit(DreamModel item) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditScreen(dream: item)));
  }

  void _onTapStared(BuildContext ctx, DreamModel dream) {
    dream.stared = !dream.stared;
    Provider.of<DbProvider>(ctx, listen: false).saveDream(dream);
  }

  static const labelsFormStyle = Styles.labelsTextStyle;
  static const contentPadding = 18.0;
  static const textFormStyle = TextStyle(fontSize: 16, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final dream = widget.item;
    final modalTitle =
        Utils().createDateTimeString(dream.timestamp, context, false);
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    final cardsColor =
        isDarkMode ? Styles.customBgCards : Styles.customLightCards;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        child: ListView(children: <Widget>[
          _buildAppBar(context, modalTitle, dream),
          const SizedBox(height: contentPadding),
          _buildTitle(dream),
          _buildDescription(context, cardsColor, dream),
          const SizedBox(height: contentPadding),
          if (dream.analysis.isNotEmpty)
            ..._buildAnalysis(context, cardsColor, dream),
          if (dream.notes.isNotEmpty)
            ..._buildNotes(context, cardsColor, dream),
          ..._buildEmotions(dream),
          _buildNightmareRecurrent(dream),
        ]),
      ),
    );
  }

  Widget _buildAppBar(
      BuildContext context, String modalTitle, DreamModel dream) {
    return ListTile(
      title: Text(modalTitle, style: Styles.primaryTextStyle),
      trailing: Wrap(
        alignment: WrapAlignment.end,
        spacing: 1,
        children: <Widget>[
          IconButton(
              onPressed: () => setState(() => _onTapStared(context, dream)),
              icon: const Icon(Icons.star),
              color: dream.stared ? Styles.seedColor : null),
          IconButton(
              onPressed: () {
                Utils().shareDream(dream, context);
              },
              icon: const Icon(Icons.share)), // icon-1
        ],
      ),
    );
  }

  Widget _buildTitle(DreamModel dream) {
    return ListTile(
        title: Text(
      dream.title.isEmpty ? AppLocalizations.of(context)!.dream : dream.title,
      style: labelsFormStyle,
    ));
  }

  Widget _buildDescription(
      BuildContext context, Color cardsColor, DreamModel dream) {
    return GestureDetector(
      onDoubleTap: () => _goToEdit(dream),
      onLongPress: () => Utils().copyOnClipboard(context, dream.description),
      child: Card(
          color: cardsColor,
          child: Padding(
              padding: const EdgeInsets.all(contentPadding),
              child: Text(style: textFormStyle, dream.description))),
    );
  }

  List<Widget> _buildAnalysis(
      BuildContext context, Color cardsColor, DreamModel dream) {
    return [
      ListTile(
          title: Text(AppLocalizations.of(context)!.analisys,
              style: labelsFormStyle)),
      GestureDetector(
          onDoubleTap: () => _goToEdit(dream),
          onLongPress: () => Utils().copyOnClipboard(context, dream.analysis),
          child: Card(
              color: cardsColor,
              child: Padding(
                  padding: const EdgeInsets.all(contentPadding),
                  child: Text(style: textFormStyle, dream.analysis)))),
    ];
  }

  List<Widget> _buildNotes(
      BuildContext context, Color cardsColor, DreamModel dream) {
    return [
      ListTile(
          title: Text(AppLocalizations.of(context)!.notes,
              style: labelsFormStyle)),
      GestureDetector(
          onDoubleTap: () => _goToEdit(dream),
          onLongPress: () => Utils().copyOnClipboard(context, dream.notes),
          child: Card(
              color: cardsColor,
              child: Padding(
                  padding: const EdgeInsets.all(contentPadding),
                  child: Text(style: textFormStyle, dream.notes)))),
    ];
  }

  List<Widget> _buildEmotions(DreamModel dream) {
    var mapEmotions = Utils().getMapEmotions(context);
    return [
      if (dream.emotions.isNotEmpty)
        ListTile(
            title: Text(AppLocalizations.of(context)!.emotions,
                style: labelsFormStyle)),
      Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22, bottom: 15),
        child: Wrap(spacing: 8, children: [
          for (var emotion in dream.emotions)
            Text(mapEmotions[emotion]!,
                textAlign: TextAlign.left, style: textFormStyle)
        ]),
      )
    ];
  }

  Widget _buildNightmareRecurrent(DreamModel dream) {
    if (!dream.nightmare && !dream.recurrent) return Container();

    final widgets = <Widget>[];

    if (dream.nightmare) {
      widgets.addAll([
        Text(AppLocalizations.of(context)!.nightmare, style: textFormStyle),
        Checkbox(
            value: dream.nightmare,
            activeColor: Styles.seedColor,
            onChanged: (bool? value) {})
      ]);
    }

    if (dream.recurrent) {
      widgets.addAll([
        Text(AppLocalizations.of(context)!.recurrent, style: textFormStyle),
        Checkbox(
            value: dream.recurrent,
            activeColor: Styles.seedColor,
            onChanged: (bool? value) {})
      ]);
    }

    return Padding(
        padding: const EdgeInsets.all(contentPadding),
        child: Wrap(
            spacing: 5,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: widgets));
  }
}
