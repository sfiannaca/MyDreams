import 'package:diaryofdreams/models/filter_model.dart';
import 'package:diaryofdreams/providers/filter_provider.dart';
import 'package:diaryofdreams/ui/layout/bottom_nav.dart';
import 'package:diaryofdreams/ui/screens/dreams/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/ui/screens/dreams/widgets/dreams_list_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DreamsTab extends StatelessWidget {
  const DreamsTab({super.key});

  @override
  Widget build(BuildContext context) {
    late Stream<List<DreamModel>> streamList;
    late FilterModel query;
    query = Provider.of<FilterProvider>(context).filters;
    streamList = Provider.of<DbProvider>(context).watchBy(query);
    final colorIcon = Theme.of(context).colorScheme.background;
    final fabBgColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 5,
          backgroundColor: fabBgColor,
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(builder: (context) => const AddScreen()),
            );
          },
          child: Icon(
            size: 32,
            Icons.add,
            color: colorIcon,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomNav(mode: 'dreams'),
      body: _buildBody(streamList),
    );
  }

  Widget _buildBody(Stream<List<DreamModel>> streamList) {
    return StreamBuilder<List<DreamModel>>(
        stream: streamList,
        builder:
            (BuildContext context, AsyncSnapshot<List<DreamModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text(AppLocalizations.of(context)!.loading));
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text(AppLocalizations.of(context)!.warnError));
          } else if (snapshot.data!.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context)!.emptyDreams));
          } else {
            return DreamsListView(list: snapshot.data!);
          }
        });
  }
}
