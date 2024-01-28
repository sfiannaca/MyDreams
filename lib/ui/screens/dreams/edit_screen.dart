import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/ui/screens/dreams/widgets/dream_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditScreen extends StatefulWidget {
  final DreamModel dream;

  const EditScreen({super.key, required this.dream});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late final DreamModel dream = widget.dream;
  late final editDreams = DreamModel()
    ..id = dream.id
    ..title = dream.title
    ..analysis = dream.analysis
    ..description = dream.description
    ..notes = dream.notes
    ..emotions = dream.emotions
    ..stared = dream.stared
    ..recurrent = dream.recurrent
    ..nightmare = dream.nightmare
    ..timestamp = dream.timestamp
    ..stared = dream.stared;

  @override
  Widget build(BuildContext context) {
    final bgScaffold = Theme.of(context).brightness == Brightness.light
        ? null
        : Colors.grey[800];

    late final List<String> newListEmotions = List.from(editDreams.emotions);
    editDreams.emotions = newListEmotions;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop)  {
        if (didPop) return;
        _showExitPopup().then(
        (confirm) {
          if (confirm) Navigator.of(context).pop();
        });
      },
      child: Scaffold(
        backgroundColor: bgScaffold,
        appBar: AppBar(
          title: Text(
              Utils().createDateTimeString(dream.timestamp, context, true),
              style: Styles.primaryTextStyle),
          actions: _buildAppBarActions(),
        ),
        body: DreamDetails(dream: editDreams, isNewDream: false),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        icon: Icon(Icons.star,
            color: editDreams.stared ? Styles.seedColor : Colors.grey),
        onPressed: () => setState(() => editDreams.stared = !editDreams.stared),
      ),
      IconButton(icon: const Icon(Icons.calendar_month), onPressed: _pickDate),
      IconButton(
          icon: const Icon(Icons.add_task, color: Styles.seedColor),
          onPressed: () => _onTapEdit(context)),
    ];
  }

  void _onTapEdit(BuildContext context) {
    if (editDreams.description.isNotEmpty) {
      dream.title = editDreams.title;
      dream.description = editDreams.description;
      dream.analysis = editDreams.analysis;
      dream.notes = editDreams.notes;
      dream.emotions = editDreams.emotions;
      dream.stared = editDreams.stared;
      dream.recurrent = editDreams.recurrent;
      dream.nightmare = editDreams.nightmare;
      dream.timestamp = editDreams.timestamp;
      dream.stared = editDreams.stared;

      Provider.of<DbProvider>(context, listen: false).saveDream(widget.dream);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  Future<bool> _showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.warn),
              content: Text(
                AppLocalizations.of(context)!.warnPreventLeave,
                style: Styles.primaryTextStyle,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(AppLocalizations.of(context)!.cancel)),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(AppLocalizations.of(context)!.confirm)),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _pickDate() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: dream.timestamp,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (newDate == null) return;
    setState(() => dream.timestamp = newDate);
  }
}
