import 'package:diaryofdreams/providers/settings_provider.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/shared/storage_helper.dart';
import 'package:diaryofdreams/ui/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  Column _buildBody(BuildContext context) {
    bool isDarkMode;
    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }

    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    return Column(
      children: [
        ListTile(
            title: Text(
          AppLocalizations.of(context)!.theme,
          style: Styles.labelsTextStyle,
        )),
        ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text(AppLocalizations.of(context)!.darkTheme,
                style: Styles.primaryTextStyle),
            trailing: Switch(
                value: isDarkMode,
                activeColor: Styles.seedColor,
                onChanged: ((bool value) {
                  isDarkMode = value;
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme(isDarkMode ? 'dark' : 'light');
                }))),
        const SizedBox(height: 20),
        ListTile(
            title: Text(
          AppLocalizations.of(context)!.language,
          style: Styles.labelsTextStyle,
        )),
        ListTile(
          onTap: (() => _dialogChangeLanguage(context, settingsProvider)),
          leading: const Icon(Icons.language),
          title: _buildLanguagePicked(context, settingsProvider),
        ),
        const SizedBox(height: 20),
        ListTile(
            title: Text(AppLocalizations.of(context)!.database,
                style: Styles.labelsTextStyle)),
        ListTile(
            onTap: (() => importBackup(context)),
            leading: const Icon(Icons.upload),
            title: Text(AppLocalizations.of(context)!.importBackup,
                style: Styles.primaryTextStyle)),
        ListTile(
            onTap: (() => exportBackup(context)),
            leading: const Icon(Icons.download),
            title: Text(AppLocalizations.of(context)!.exportBackup,
                style: Styles.primaryTextStyle)),
        ListTile(
            leading: const Icon(Icons.delete_sweep_outlined),
            title: Text(AppLocalizations.of(context)!.deleteAll,
                style: Styles.primaryTextStyle),
            onTap: () => _dialogCleanDatabase(context)),
        const SizedBox(height: 20),
        ListTile(
            title: Text(AppLocalizations.of(context)!.print,
                style: Styles.labelsTextStyle)),
        ListTile(
            onTap: (() => exportDreams(context)),
            leading: const Icon(Icons.text_snippet),
            title: Text(AppLocalizations.of(context)!.printDreams,
                style: Styles.primaryTextStyle)),
        ListTile(
            onTap: (() => exportBooks(context)),
            leading: const Icon(Icons.text_snippet),
            title: Text(AppLocalizations.of(context)!.printBooks,
                style: Styles.primaryTextStyle)),
      ],
    );
  }

  Future<void> _dialogChangeLanguage(
      BuildContext context, SettingsProvider settingsProvider) {
    const supportedLocales = AppLocalizations.supportedLocales;
    final currentLocale = settingsProvider.locale;

    List<Widget> radioButtons = supportedLocales.map((locale) {
      final isEnglish = locale.languageCode == 'en';
      final title = isEnglish
          ? AppLocalizations.of(context)!.languageEng
          : AppLocalizations.of(context)!.languageIta;

      final selected = title.toLowerCase().contains(currentLocale);

      return RadioListTile(
        title: Text(title),
        value: locale.languageCode,
        selected: selected,
        groupValue: currentLocale,
        onChanged: (value) {
          settingsProvider.setLocale(value!);
          Navigator.of(context).pop();
        },
      );
    }).toList();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(""),
          titlePadding: EdgeInsets.zero,
          actions: radioButtons,
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.settings),
    );
  }

  Future<void> _dialogCleanDatabase(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.warn),
          content: Text(
            AppLocalizations.of(context)!.warnClearDb,
            style: Styles.primaryTextStyle,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(AppLocalizations.of(context)!.confirm),
              onPressed: () {
                Provider.of<DbProvider>(context, listen: false).cleanDb();
                Navigator.of(context).pop();
                Utils().customSnackBar(
                    context, AppLocalizations.of(context)!.success);
              },
            ),
          ],
        );
      },
    );
  }

  void importBackup(BuildContext context) {
    StorageHelper().pickBackup().then((bk) {
      if (bk.isEmpty) {
        Utils().customSnackBar(
            context, AppLocalizations.of(context)!.warnNotDataImported);
      } else {
        final dreams = bk.first.dreams;
        final books = bk.first.books;
        for (var dream in dreams) {
          Provider.of<DbProvider>(context, listen: false).saveDream(dream);
        }
        for (var book in books) {
          Provider.of<DbProvider>(context, listen: false).saveBook(book);
        }
        Utils().customSnackBar(context, AppLocalizations.of(context)!.success);
      }
    });
  }

  void exportBackup(BuildContext context) async {
    StorageHelper().pickDirectory().then((var path) {
      if (path == null) {
        return Utils().customSnackBar(
            context, AppLocalizations.of(context)!.warnInvalidPath);
      }

      Provider.of<DbProvider>(context, listen: false).getDreams().then(
        (dreams) {
          Provider.of<DbProvider>(context, listen: false)
              .getBooks()
              .then((books) {
            StorageHelper().exportBackup(context, path, dreams, books);
          });
        },
      );
    });
  }

  void exportDreams(BuildContext context) async {
    StorageHelper().pickDirectory().then((var path) => {
          if (path == null)
            Utils().customSnackBar(
                context, AppLocalizations.of(context)!.warnInvalidPath)
          else
            {
              Provider.of<DbProvider>(context, listen: false)
                  .getDreams()
                  .then((list) {
                StorageHelper().saveDreamsToText(context, path, list);
              })
            }
        });
  }

  void exportBooks(BuildContext context) async {
    StorageHelper().pickDirectory().then((var path) => {
          if (path == null)
            Utils().customSnackBar(
                context, AppLocalizations.of(context)!.warnInvalidPath)
          else
            {
              Provider.of<DbProvider>(context, listen: false)
                  .getBooks()
                  .then((list) {
                StorageHelper().saveBooksToText(context, path, list);
              })
            }
        });
  }

  Widget _buildLanguagePicked(
      BuildContext context, SettingsProvider settingsProvider) {
    final textString =
        settingsProvider.getFullLanguageName(settingsProvider.locale);

    return Text(textString, style: Styles.primaryTextStyle);
  }
}
