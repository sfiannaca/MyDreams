import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/dreams/widgets/modal_preview.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DreamsListView extends StatefulWidget {
  const DreamsListView({
    super.key,
    required this.list,
  });

  final List<DreamModel> list;

  @override
  State<DreamsListView> createState() => _DreamsListViewState();
}

class _DreamsListViewState extends State<DreamsListView> {
  late DateTime today;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    today = DateTime.now();
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
    final bgColor = Theme.of(context).brightness == Brightness.dark
        ? Styles.customDarkCards
        : Styles.customLightCards;
    const dividerSpace = 8.0;

    return Padding(
      padding: const EdgeInsets.all(dividerSpace),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (item.stared)
              const Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(children: [
                  Icon(
                    Icons.star,
                    color: Styles.seedColor,
                  )
                ]),
              ),
            Expanded(
              flex: 5,
              child: Material(
                  color: bgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                      onTap: () {
                        showBarModalBottomSheet(
                          expand: true,
                          context: context,
                          builder: (context) => ModalPreview(
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

  Widget _rowTile(DreamModel item) {
    const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 17,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400);

    return ListTile(
        title: Text(
            maxLines: 5,
            style: textStyle,
            item.title.isNotEmpty ? item.title : item.description));
  }
}
