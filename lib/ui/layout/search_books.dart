import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/ui/screens/book/widgets/book_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBook extends SearchDelegate {
  late Stream<List<BookModel>> books;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
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
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    books = Provider.of<DbProvider>(context, listen: false)
        .searchBooksAndWatchBy(query);
    return Stack(
      children: [
        StreamBuilder<List<BookModel>>(
            stream: books,
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
                        child: Text(AppLocalizations.of(context)!.warnNoData));
                  }

                  if (snapshot.hasError) {
                    return Text(AppLocalizations.of(context)!.warnError);
                  }

                  if (snapshot.hasData) {
                    return BookListView(list: snapshot.data!);
                  } else {
                    return const Center(child: Text(''));
                  }
              }
            }),
        if (query.isNotEmpty)
          Positioned(
              bottom: 18,
              right: 18,
              child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  onPressed: () {
                    query = "";
                  },
                  child: const Icon(
                    Icons.filter_alt_off,
                    color: Colors.red,
                  ))),
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
