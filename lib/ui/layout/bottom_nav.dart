import 'dart:math' show pi;
import 'package:diaryofdreams/models/filter_model.dart';
import 'package:diaryofdreams/providers/filter_provider.dart';
import 'package:diaryofdreams/ui/layout/search_books.dart';
import 'package:diaryofdreams/ui/layout/widgets/menu_modal.dart';
import 'package:diaryofdreams/ui/screens/dreams/widgets/modal_filter.dart';
import 'package:flutter/material.dart';
import 'package:diaryofdreams/ui/layout/search_dreams.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.mode,
  });

  final String mode;

  @override
  Widget build(BuildContext context) {
    final colorIcon = Theme.of(context).colorScheme.primary;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      elevation: 0,
      child: Row(children: [
        IconButton(
            icon: Icon(
              Icons.menu,
              color: colorIcon,
            ),
            onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => MenuModal(context: context),
                )),
        if (mode == 'dreams') ..._buildDreamsMode(context),
        if (mode == 'books') ..._buildBooksMode(context),
      ]),
    );
  }

  _buildDreamsMode(BuildContext context) {
    FilterModel filters;
    filters = Provider.of<FilterProvider>(context).filters;
    final colorIcon = Theme.of(context).colorScheme.primary;
    return [
      IconButton(
          icon: Icon(
            Icons.search,
            color: colorIcon,
          ),
          onPressed: () {
            Provider.of<FilterProvider>(context, listen: false).resetValues();
            showSearch(context: context, delegate: SearchDream());
          }),
      IconButton(
          icon: Icon(
            Icons.filter_list,
            color: colorIcon,
          ),
          onPressed: () => showBarModalBottomSheet(
                context: context,
                builder: (context) => ModalFilter(context: context),
              )),
      if (filters.isActive())
        IconButton(
            icon: const Icon(
              Icons.filter_list_off,
              color: Colors.red,
            ),
            onPressed: () {
              Provider.of<FilterProvider>(context, listen: false).resetValues();
            }),
      Transform.rotate(
          angle: 90 * pi / 180,
          child: IconButton(
              icon: Icon(
                Icons.swap_horiz,
                color: colorIcon,
              ),
              onPressed: () {
                Provider.of<FilterProvider>(context, listen: false)
                    .reverseList(!filters.reverseList);
              }))
    ];
  }

  _buildBooksMode(BuildContext context) {
    final colorIcon = Theme.of(context).colorScheme.primary;
    return [
      IconButton(
          icon: Icon(
            Icons.search,
            color: colorIcon,
          ),
          onPressed: () {
            Provider.of<FilterProvider>(context, listen: false).resetValues();
            showSearch(context: context, delegate: SearchBook());
          }),
    ];
  }
}
