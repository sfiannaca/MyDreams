import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/book/quick_book_tab.dart';
import 'package:flutter/material.dart';
import 'package:diaryofdreams/models/dream_model.dart' show DreamModel;
import 'package:diaryofdreams/ui/screens/dreams/widgets/multi_select_chip.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DreamDetails extends StatefulWidget {
  const DreamDetails({
    super.key,
    required this.dream,
    required this.isNewDream,
  });

  final DreamModel dream;
  final bool isNewDream;

  @override
  State<DreamDetails> createState() => _DreamDetailsState();
}

class _DreamDetailsState extends State<DreamDetails> {
  @override
  Widget build(BuildContext context) {
    const contentPadding = 18.0;
    const hSpacing = 25.0;
    const labelsPadding = contentPadding;

    const labelTextStyle = Styles.labelsTextStyle;
    const textFormStyle = Styles.secondaryTextStyle;

    final cardsColor = Theme.of(context).canvasColor;

    final widgets = [
      const SizedBox(height: hSpacing),
      Padding(
        padding: const EdgeInsets.only(left: contentPadding),
        child: Text(
          AppLocalizations.of(context)!.title,
          style: labelTextStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Card(
          color: cardsColor,
          child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(contentPadding),
              ),
              minLines: 1,
              maxLines: 4,
              style: textFormStyle,
              initialValue: widget.dream.title,
              textCapitalization: TextCapitalization.sentences,
              onChanged: ((value) => setState(() {
                    widget.dream.title = value.trim();
                  }))),
        ),
      ),
      const SizedBox(height: hSpacing),
      Padding(
        padding: const EdgeInsets.only(left: contentPadding),
        child: Text(
          AppLocalizations.of(context)!.description,
          style: labelTextStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Card(
          color: cardsColor,
          child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(contentPadding),
              ),
              minLines: 3,
              maxLines: null,
              autofocus: widget.isNewDream,
              initialValue: widget.dream.description,
              style: textFormStyle,
              textCapitalization: TextCapitalization.sentences,
              onChanged: ((value) => setState(() {
                    widget.dream.description = value.trim();
                  }))),
        ),
      ),
      const SizedBox(height: hSpacing),
      Padding(
        padding:
            const EdgeInsets.only(left: labelsPadding, right: labelsPadding),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            AppLocalizations.of(context)!.analisys,
            style: labelTextStyle,
            textAlign: TextAlign.left,
          ),
          IconButton(
              icon: const Icon(Icons.library_books),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuickBookTab()),
                );
              }),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Card(
          color: cardsColor,
          child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(contentPadding),
              ),
              initialValue: widget.dream.analysis,
              maxLines: null,
              style: textFormStyle,
              textCapitalization: TextCapitalization.sentences,
              onChanged: ((value) => setState(() {
                    widget.dream.analysis = value.trim();
                  }))),
        ),
      ),
      const SizedBox(height: hSpacing),
      Padding(
        padding: const EdgeInsets.only(left: labelsPadding),
        child: Text(
          AppLocalizations.of(context)!.notes,
          style: labelTextStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Card(
          color: cardsColor,
          child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(contentPadding),
              ),
              minLines: 1,
              maxLines: null,
              initialValue: widget.dream.notes,
              style: textFormStyle,
              textCapitalization: TextCapitalization.sentences,
              onChanged: ((value) => setState(() {
                    widget.dream.notes = value.trim();
                  }))),
        ),
      ),
      const SizedBox(height: hSpacing),
      Padding(
        padding:
            const EdgeInsets.only(left: labelsPadding, right: labelsPadding),
        child: Text(
          AppLocalizations.of(context)!.emotions,
          style: labelTextStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
        child: MultiSelectChip(
          selectedItem: widget.dream.emotions,
          isUsedByFilter: false,
        ),
      ),
      const SizedBox(height: hSpacing),
      Wrap(
        spacing: 5,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.nightmare,
            style: Styles.secondaryTextStyle,
          ),
          Checkbox(
            activeColor: Styles.seedColor,
            value: widget.dream.nightmare,
            onChanged: (bool? value) {
              setState(() {
                widget.dream.nightmare = value!;
              });
            },
          ),
          Text(AppLocalizations.of(context)!.recurrent,
              style: Styles.secondaryTextStyle),
          Checkbox(
            value: widget.dream.recurrent,
            activeColor: Styles.seedColor,
            onChanged: (bool? value) {
              setState(() {
                widget.dream.recurrent = value!;
              });
            },
          ),
        ],
      ),
      const SizedBox(height: hSpacing),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!widget.isNewDream)
            SizedBox(
              height: 45,
              width: 150,
              child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: () => _buildDeleteDialog(widget.dream),
                  label: Text(AppLocalizations.of(context)!.delete)),
            ),
          if (!widget.isNewDream) const SizedBox(width: hSpacing),
          SizedBox(
            height: 45,
            width: 150,
            child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Styles.seedColor),
                onPressed: () => _onTapSave(),
                label: Text(
                  AppLocalizations.of(context)!.save,
                  style: const TextStyle(color: Colors.white),
                )),
          ),
        ],
      )
    ];

    return ListView(
        padding: const EdgeInsets.only(bottom: 50), children: widgets);
  }

  _onTapSave() {
    if (widget.dream.description.isEmpty) return;
    Provider.of<DbProvider>(context, listen: false).saveDream(widget.dream);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _buildDeleteDialog(DreamModel dream) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.warn),
          content: Text(
            AppLocalizations.of(context)!.warnDeleteDream,
            style: Styles.primaryTextStyle,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(AppLocalizations.of(context)!.confirm),
              onPressed: () {
                Provider.of<DbProvider>(context, listen: false)
                    .deleteDream(dream);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
}
