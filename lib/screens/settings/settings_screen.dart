import 'dart:io';

import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:passwd/widgets/export.dart';

import '../../utils/loggers.dart';
import '../../widgets/sync/settings_sync_widget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.getString('settings'),
          style: TextStyle(
            letterSpacing: 1.25,
            fontSize: 18,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          tooltip: context.getString('back_tooltip'),
          icon: Icon(Feather.x_circle),
        ),
      ),
      body: ListView(
        children: [
          if (Platform.isAndroid)
            ListTile(
              title: Text(context.getString('activate_autofill_service')),
              onTap: () async {
                // TODO: abstract autofill
                final response =
                    await AutofillService().requestSetAutofillService();
                Loggers.mainLogger.info(
                  'Autofill requestSetAutofillService: ${response}',
                );
              },
            ),
          SettingsSyncWidget(),
          ExportSettingsWidget(),
        ],
      ),
    );
  }
}
