import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/ui/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/theme_provider.dart';

class MenuModal extends StatefulWidget {
  const MenuModal({
    super.key,
    required this.context,
  });

  final BuildContext context;
  @override
  State<MenuModal> createState() => _MenuModalState();
}

class _MenuModalState extends State<MenuModal> {
  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    );

    return Container(
        decoration: boxDecoration, height: 190, child: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    return Column(children: [
      ListTile(
        trailing: IconButton(
          onPressed: () {
            setState(() {
              isDarkMode = !isDarkMode;
              Provider.of<ThemeProvider>(context, listen: false)
                  .changeTheme(isDarkMode ? 'dark' : 'light');
            });
          },
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
        ),
      ),
      ListTile(
          leading: const Icon(Icons.settings),
          title: Text(
            AppLocalizations.of(context)!.settings,
            style: Styles.primaryTextStyle,
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          }),
    ]);
  }
}
