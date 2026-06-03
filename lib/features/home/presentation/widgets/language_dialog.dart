import 'package:expense_tracker_app/core/language/language_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.read<LanguageService>();

    return AlertDialog(
      title: Text(lang.text('settings')),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("English"),
            onTap: () {
              lang.loadLanguage('en');
              Navigator.pop(context);
            },
          ),

          ListTile(
            title: const Text("မြန်မာ"),
            onTap: () {
              lang.loadLanguage('my');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}