import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/book/widgets/book_details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final newBook = BookModel();

  @override
  Widget build(BuildContext context) {
    final bgScaffold = Theme.of(context).brightness == Brightness.light
        ? null // unset
        : Colors.grey[800];

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
          actions: [
            IconButton(
                icon: const Icon(Icons.add_task, color: Styles.seedColor),
                onPressed: () {
                  _onTapSave(context);
                }),
          ],
        ),
        body: BookDetails(book: newBook, isNewBook: true),
      ),
    );
  }

  Future<bool> _showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.warn),
            content: Text(
              AppLocalizations.of(context)!.warnPreventLeave,
              style: Styles.primaryTextStyle,
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.confirm),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _onTapSave(BuildContext context) {
    if (newBook.meaning.isEmpty) return;
    Provider.of<DbProvider>(context, listen: false).saveBook(newBook);
    Navigator.pop(context);
  }
}
