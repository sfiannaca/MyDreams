import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const contentPadding = 12.0;
const hSpacing = 30.0;

class BookDetails extends StatefulWidget {
  const BookDetails({
    super.key,
    required this.book,
    required this.isNewBook,
  });

  final BookModel book;
  final bool isNewBook;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final cardsColor = Theme.of(context).canvasColor;
    const contentPadding = 18.0;

    const textFormStyle = Styles.secondaryTextStyle;
    const labelsFormStyle = Styles.labelsTextStyle;

    final widgets = [
      const SizedBox(height: hSpacing),
      Padding(
        padding:
            const EdgeInsets.only(left: contentPadding, right: contentPadding),
        child: Text(
          AppLocalizations.of(context)!.book,
          style: labelsFormStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16, top: 3, right: 16),
        child: Card(
          color: cardsColor,
          child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(contentPadding),
              ),
              minLines: 1,
              maxLines: 4,
              style: textFormStyle,
              initialValue: widget.book.title,
              textCapitalization: TextCapitalization.sentences,
              onChanged: ((value) => setState(() {
                    widget.book.title = value.trim();
                  }))),
        ),
      ),
      const SizedBox(height: hSpacing),
      Padding(
        padding: const EdgeInsets.only(
            left: contentPadding, top: 3, right: contentPadding),
        child: Text(
          AppLocalizations.of(context)!.description,
          style: labelsFormStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16, top: 3, right: 16),
        child: Card(
          color: cardsColor,
          child: TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(contentPadding),
              ),
              minLines: 10,
              maxLines: null,
              autofocus: widget.isNewBook,
              initialValue: widget.book.meaning,
              style: textFormStyle,
              textCapitalization: TextCapitalization.sentences,
              onChanged: ((value) => setState(() {
                    widget.book.meaning = value.trim();
                  }))),
        ),
      ),
      const SizedBox(height: hSpacing),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!widget.isNewBook)
            SizedBox(
              height: 45,
              width: 150,
              child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: () => _buildDeleteDialog(widget.book),
                  label: Text(AppLocalizations.of(context)!.delete)),
            ),
          if (!widget.isNewBook) const SizedBox(width: hSpacing),
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
    if (widget.book.meaning.isEmpty) return;
    Provider.of<DbProvider>(context, listen: false).saveBook(widget.book);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _buildDeleteDialog(BookModel book) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.warn),
          content: Text(AppLocalizations.of(context)!.warnDeleteBook,
              style: Styles.primaryTextStyle),
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
                    .deleteBook(book);
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
}
