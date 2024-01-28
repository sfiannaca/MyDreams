import 'package:diaryofdreams/models/book_model.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/ui/layout/bottom_nav.dart';
import 'package:diaryofdreams/ui/screens/book/add_book_screen.dart';
import 'package:diaryofdreams/ui/screens/book/widgets/book_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookTab extends StatelessWidget {
  const BookTab({super.key});

  @override
  Widget build(BuildContext context) {
    late Stream<List<BookModel>> streamList;
    streamList = Provider.of<DbProvider>(context).watchBooks();
    final colorIcon = Theme.of(context).colorScheme.background;
    final fabBgColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 5,
          backgroundColor: fabBgColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddBookScreen()),
            );
          },
          child: Icon(
            size: 32,
            Icons.add,
            color: colorIcon,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomNav(mode: 'books'),
      body: _buildBody(streamList),
    );
  }

  Widget _buildBody(Stream<List<BookModel>> streamList) {
    return StreamBuilder<List<BookModel>>(
      stream: streamList,
      builder: (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: Text(AppLocalizations.of(context)!.loading));
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return Text(AppLocalizations.of(context)!.warnError);
            }

            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(AppLocalizations.of(context)!.warnNoData));
              }
              return BookListView(list: snapshot.data!);
            } else {
              return const Center(child: Text(''));
            }
        }
      },
    );
  }
}
