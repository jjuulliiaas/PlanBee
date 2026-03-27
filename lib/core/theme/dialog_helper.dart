import 'package:flutter/cupertino.dart';

class DialogsHelper {
  /// Approve of all data deleting
  static Future<void> showClearDataDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) async {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This action is permanent. All your honey tasks will be deleted.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}