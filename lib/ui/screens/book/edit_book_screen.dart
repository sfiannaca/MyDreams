import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/book/widgets/book_details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditBookScreen extends StatefulWidget {
  const EditBookScreen({super.key, required this.book});

  final BookModel book;

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late final book = widget.book;
  late final editBook = BookModel()
    ..id = book.id
    ..title = book.title
    ..meaning = book.meaning;

  @override
  Widget build(BuildContext context) {
    const appBarTitle = "Edita";
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
          title: const Text(
            appBarTitle,
            style: Styles.primaryTextStyle,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.add_task,
                    color: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  _onTapSave(context);
                }),
          ],
        ),
        body: BookDetails(book: editBook, isNewBook: false),
      ),
    );
  }

  void _onTapSave(BuildContext context) {
    if (editBook.meaning.isEmpty) return;
    book.title = editBook.title;
    book.meaning = editBook.meaning;

    Provider.of<DbProvider>(context, listen: false).saveBook(editBook);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<bool> _showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.warn),
            content: Text(AppLocalizations.of(context)!.warnPreventLeave,
                style: Styles.primaryTextStyle),
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
          ),
        ) ??
        false;
  }
}
