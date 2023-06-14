import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Assets/texts.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  State<LanguageDropdown> createState() => _LanguageDropdown();
}

class _LanguageDropdown extends State<LanguageDropdown> {
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: toggleExpanded,
          leading: const Icon(Icons.language),
          title: Text('Select Language'.tr),
        ),
        if (isExpanded)
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            elevation: 1,
            dividerColor: Colors.grey[200],
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text('Choose One'.tr),
                    onTap: toggleExpanded,
                  );
                },
                body: Column(
                  children: [
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.sort_by_alpha),
                      title: Text('English'.tr),
                      onTap: () {
                        var locale = const Locale('en', 'US');
                        Get.updateLocale(locale);
                        toggleExpanded(); // Close the dropdown
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.sign_language_outlined),
                      title: Text('Urdu'.tr),
                      onTap: () {
                        var locale = const Locale('ur', 'PK');
                        Get.updateLocale(locale);
                        toggleExpanded(); // Close the dropdown
                      },
                    ),
                  ],
                ),
                isExpanded: true,
              ),
            ],
          ),
      ],
    );
  }
}
