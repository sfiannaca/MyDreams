import 'package:diaryofdreams/styles.dart';
import 'package:flutter/material.dart';
import 'package:diaryofdreams/ui/screens/dreams/dreams_tab.dart';
import 'package:diaryofdreams/ui/screens/stats/stats_tab.dart';
import 'package:diaryofdreams/ui/screens/book/book_tab.dart';

class NavTabs extends StatelessWidget {
  const NavTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final colorIcon = Theme.of(context).colorScheme.secondary;
    final kTabPages = <Widget>[
      const BookTab(),
      const DreamsTab(),
      const StatsTab(),
    ];
    final kTabs = <Tab>[
      Tab(
          icon: Icon(
        Icons.library_books,
        size: 24,
        color: colorIcon,
      )),
      Tab(
          icon: Icon(
        Icons.menu_book,
        size: 24,
        color: colorIcon,
      )),
      Tab(
          icon: Icon(
        Icons.bar_chart,
        color: colorIcon,
        size: 24,
      )),
    ];

    return DefaultTabController(
      length: kTabs.length,
      initialIndex: 1,
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  automaticIndicatorColorAdjustment: true,
                  indicatorWeight: 4,
                  indicatorColor: Styles.seedColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: kTabs,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: kTabPages,
          )),
    );
  }
}
