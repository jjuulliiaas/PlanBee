import 'package:flutter/cupertino.dart';

import '../../generated/l10n.dart';

class DialogsHelper {
  /// Approve of all data deleting
  static Future<void> showClearDataDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) async {
    final $ = S.of(context);
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text($.clearAllDataTitle),
        content: Text(
          $.clearAllDataDescription,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text($.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: Text($.clear),
          ),
        ],
      ),
    );
  }
}