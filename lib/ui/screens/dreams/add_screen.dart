import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/ui/screens/dreams/widgets/dream_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late DateTime currentDate = DateTime.now();
  final newDream = DreamModel();

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: Text(
            Utils().createDateTimeString(newDream.timestamp, context, true),
            style: Styles.primaryTextStyle,
          ),
          actions: _buildAppBarActions(),
        ),
        body: DreamDetails(dream: newDream, isNewDream: true),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
          icon: Icon(
            Icons.star,
            color: newDream.stared ? Styles.seedColor : Colors.grey,
          ),
          onPressed: () {
            setState(() => newDream.stared = !newDream.stared);
          }),
      IconButton(icon: const Icon(Icons.calendar_month), onPressed: _pickDate),
      IconButton(
          icon: const Icon(Icons.add_task, color: Styles.seedColor),
          onPressed: () {
            _onTapSave(context);
          }),
    ];
  }

  Future<bool> _showExitPopup() async {
    return await showDialog<bool>(
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
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(AppLocalizations.of(context)!.confirm),
                  ),
                ],
              );
            }) ??
        false;
  }

  Future<void> _pickDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(currentDate.year + 1),
    );
    if (newDate == null || newDate.year == currentDate.year + 1) {
      return;
    }
    setState(() {
      newDream.timestamp = newDate;
    });
  }

  void _onTapSave(BuildContext context) {
    if (newDream.description.isEmpty) return;
    Provider.of<DbProvider>(context, listen: false).saveDream(newDream);
    Navigator.pop(context);
  }
}
