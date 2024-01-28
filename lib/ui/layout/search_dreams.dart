import 'package:diaryofdreams/providers/filter_provider.dart';
import 'package:diaryofdreams/ui/screens/dreams/widgets/modal_filter.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/ui/screens/dreams/widgets/dreams_list_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchDream extends SearchDelegate {
  late Stream<List<DreamModel>> dreams;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            Provider.of<FilterProvider>(context, listen: false).resetValues();
          },
          icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        Navigator.pop(context);
        Provider.of<FilterProvider>(context, listen: false).resetValues();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filters = Provider.of<FilterProvider>(context).filters;
    final activeFilter = filters.isActive();

    dreams = Provider.of<DbProvider>(context, listen: false)
        .searchAndWatchBy(query, filters);
    return Stack(
      children: [
        StreamBuilder<List<DreamModel>>(
            stream: dreams,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                default:
                  if (!snapshot.hasData) {
                    return Center(
                        child: Text(AppLocalizations.of(context)!.emptyDreams));
                  }

                  if (snapshot.hasError) {
                    return Text(AppLocalizations.of(context)!.warnError);
                  }

                  if (snapshot.hasData) {
                    return DreamsListView(list: snapshot.data!);
                  } else {
                    return const Center(child: Text(''));
                  }
              }
            }),
        Positioned(
            bottom: 18,
            right: 18,
            child: FloatingActionButton(
                heroTag: 'ModalSearchFilter',
                onPressed: () => showBarModalBottomSheet(
                      context: context,
                      builder: (context) => ModalFilter(context: context),
                    ),
                child: const Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                ))),
        if (activeFilter)
          Positioned(
              bottom: 100,
              right: 18,
              child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  onPressed: () {
                    Provider.of<FilterProvider>(context, listen: false)
                        .resetValues();
                  },
                  child: const Icon(
                    Icons.filter_alt_off,
                    color: Colors.red,
                  )))
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.searchText),
    );
  }
}
