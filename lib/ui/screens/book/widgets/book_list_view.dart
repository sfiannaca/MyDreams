import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/book/widgets/modal_book_preview.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BookListView extends StatefulWidget {
  const BookListView({
    super.key,
    required this.list,
  });

  final List<BookModel> list;

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 32.0;
    const topSpacing = spacing / 2;
    const bottomSpacing = spacing * 2;

    return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: _buildRow,
        padding: const EdgeInsets.only(top: topSpacing, bottom: bottomSpacing));
  }

  Widget _buildRow(BuildContext ctx, int index) {
    final item = widget.list[index];
    const dividerSpace = 8.0;
    final bgColor = Theme.of(context).brightness == Brightness.dark
        ? Styles.customDarkCards
        : Styles.customLightCards;

    return Padding(
      padding: const EdgeInsets.all(dividerSpace),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Material(
                  color: bgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                      onTap: () {
                        showBarModalBottomSheet(
                          expand: true,
                          context: context,
                          builder: (context) => ModalBookPreview(
                            context: context,
                            item: item,
                          ),
                        );
                      },
                      child: _rowTile(item))),
            ),
          ]),
    );
  }

  Widget _rowTile(BookModel item) {
    const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400);

    return ListTile(
        title: Text(
            maxLines: 5,
            style: textStyle,
            item.title.isNotEmpty ? item.title : item.meaning));
  }
}
