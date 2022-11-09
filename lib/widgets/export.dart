import 'dart:io';

import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';

import '../models/export.dart';
import '../services/export/export_service.dart';
import '../services/locator.dart';
import '../utils/loggers.dart';

class ExportSettingsWidget extends StatelessWidget {
  Future<void> showExportSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Wrap(
          children: [
            if (Platform.isAndroid || Platform.isIOS)
              ListTile(
                title: Text(
                    "${context.getString('share')} ${context.getString('unencrypted')}"),
                onTap: () async {
                  Navigator.of(context).pop();
                  await exportShareUnencrypted(context);
                },
              ),
            if (Platform.isAndroid || Platform.isIOS)
              ListTile(
                title: Text(
                    "${context.getString('share')} ${context.getString('encrypted')}"),
                onTap: () async {
                  Navigator.of(context).pop();
                  await exportShareEncrypted(context);
                },
              ),
            if (!Platform.isIOS)
              ListTile(
                title: Text(context.getString('save') +
                    ' ' +
                    context.getString('unencrypted')),
                onTap: () async {
                  Navigator.of(context).pop();
                  await exportSaveUnencrypted(context);
                },
              ),
            if (!Platform.isIOS)
              ListTile(
                title: Text(context.getString('save') +
                    ' ' +
                    context.getString('encrypted')),
                onTap: () async {
                  Navigator.of(context).pop();
                  await exportSaveEncrypted(context);
                },
              ),
            ListTile(
              title: Text(context.getString('cancel')),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> exportShareEncrypted(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.getString('warning')),
        content: Text(
          context.getString('import_db_warn_pin'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(context.getString('no')),
          ),
          TextButton(
            onPressed: () async {
              Loggers.mainLogger.info(
                'Export Type SHARE_ENCRYPTED',
              );
              Navigator.of(context).pop();
              await locator<ExportService>().export(ExportType.SHARE_ENCRYPTED);
            },
            child: Text(context.getString('yes')),
          ),
        ],
      ),
    );
  }

  Future<void> exportShareUnencrypted(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.getString('are_you_sure').toUpperCase()),
        content: Text(context.getString('export_unencrypted_warn')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(context.getString('no')),
          ),
          TextButton(
            onPressed: () async {
              Loggers.mainLogger.info(
                'Export Type SHARE_UNENCRYPTED',
              );
              Navigator.of(context).pop();
              await locator<ExportService>()
                  .export(ExportType.SHARE_UNENCRYPTED);
            },
            child: Text(context.getString('yes')),
          ),
        ],
      ),
    );
  }

  Future<void> exportSaveUnencrypted(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.getString('are_you_sure').toUpperCase()),
        content: Text(context.getString('export_unencrypted_warn')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(context.getString('no')),
          ),
          TextButton(
            onPressed: () async {
              Loggers.mainLogger.info(
                'Export Type SAVE_TO_STORAGE_UNENCRYPTED',
              );
              Navigator.of(context).pop();
              await locator<ExportService>()
                  .export(ExportType.SAVE_TO_STORAGE_UNENCRYPTED);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.getString('file_saved_to_docs'),
                  ),
                ),
              );
            },
            child: Text(context.getString('yes')),
          ),
        ],
      ),
    );
  }

  Future<void> exportSaveEncrypted(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.getString('warning')),
        content: Text(context.getString('import_db_warn_pin')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(context.getString('no')),
          ),
          TextButton(
            onPressed: () async {
              Loggers.mainLogger.info(
                'Export Type SAVE_TO_STORAGE_ENCRYPTED',
              );
              Navigator.of(context).pop();
              await locator<ExportService>()
                  .export(ExportType.SAVE_TO_STORAGE_ENCRYPTED);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.getString('file_saved_to_docs'),
                  ),
                ),
              );
            },
            child: Text(context.getString('yes')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.getString('export')),
      onTap: () async {
        Loggers.mainLogger.info(
          'Export exportService requested',
        );
        await showExportSheet(context);
      },
    );
  }
}
