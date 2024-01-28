import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/book/edit_book_screen.dart';
import 'package:diaryofdreams/ui/shared/utils.dart';
import 'package:flutter/material.dart';

class ModalBookPreview extends StatefulWidget {
  const ModalBookPreview({
    super.key,
    required this.context,
    required this.item,
  });

  final BuildContext context;
  final BookModel item;
  @override
  State<ModalBookPreview> createState() => _ModalBookPreviewState();
}

class _ModalBookPreviewState extends State<ModalBookPreview> {
  @override
  Widget build(BuildContext context) {
    BookModel book = widget.item;
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;
    const modalSpacing = 20.0;
    final cardsColor =
        isDarkMode ? Styles.customBgCards : Styles.customLightCards;
    final bgScaffold = isDarkMode ? Colors.grey[800] : Colors.white;

    const textFormStyle = TextStyle(fontSize: 16, color: Colors.white);

    return Scaffold(
      backgroundColor: bgScaffold,
      body: Container(
          padding: const EdgeInsets.all(12),
          child: ListView(children: <Widget>[
            const SizedBox(height: modalSpacing),
            // TITLE
            ListTile(
              title: Text(book.title, style: Styles.labelsTextStyle),
            ),
            GestureDetector(
              onDoubleTap: () => _goToEdit(book),
              onLongPress: () => Utils().copyOnClipboard(context, book.meaning),
              child: Card(
                color: cardsColor,
                child: Padding(
                  padding: const EdgeInsets.all(modalSpacing),
                  child: Text(style: textFormStyle, book.meaning),
                ),
              ),
            ),
          ])),
    );
  }

  void _goToEdit(BookModel book) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditBookScreen(book: book)));
  }
}
