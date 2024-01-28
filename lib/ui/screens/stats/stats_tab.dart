import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/stats/widgets/heatmap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/models/dream_model.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<List<DreamModel>> stream =
        Provider.of<DbProvider>(context).watchDreams();

    return SingleChildScrollView(
      child: StreamBuilder(
          stream: stream,
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: Text(AppLocalizations.of(context)!.loading));
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return Text(AppLocalizations.of(context)!.warnError);
                }
                if (snapshot.hasData) {
                  return _buildBody(context, snapshot);
                } else {
                  return const Center(child: Text(''));
                }
            }
          })),
    );
  }

  Column _buildBody(
      BuildContext context, AsyncSnapshot<List<DreamModel>> snapshot) {
    const topSpacing = 16.0;

    int? nDreams = snapshot.data!.length;
    //List<DreamModel> listOfDreams = List.from(snapshot.data!);

    return Column(children: [
      const SizedBox(height: topSpacing),
      CustomHeatMap(list: snapshot.data!),
      ListTile(
          title: Text(
            AppLocalizations.of(context)!.nDreams,
            style: Styles.primaryTextStyle,
          ),
          trailing: Text("$nDreams", style: Styles.primaryTextStyle)),
    ]);
  }
}
