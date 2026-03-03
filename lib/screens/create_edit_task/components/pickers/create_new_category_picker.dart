import 'package:flutter/material.dart';
import 'package:planbee/widgets/base_picker_layout.dart';

import '../../../../widgets/app_confirm_button.dart';
import 'icon_picker.dart';

class CreateNewCategoryPicker extends StatefulWidget {
  const CreateNewCategoryPicker({super.key});

  @override
  State<CreateNewCategoryPicker> createState() => _CreateNewCategoryPickerState();
}

class _CreateNewCategoryPickerState extends State<CreateNewCategoryPicker> {
  final _key = GlobalKey<FormState>();
  final _controller = TextEditingController();

  IconData? _chosenIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BasePickerLayout(
        title: 'Create New Category',
        children: [
          Form(
            key: _key,
            child: TextFormField(
              controller: _controller,
              onChanged: (_) => setState(() {}),
              validator: null,
              style: textTheme.bodyLarge,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: 'Category title'
              ),
            ),
          ),
          const Divider(),
          IconPicker(
            onIconSelected: (icon) {
              _chosenIcon = icon;
            },
          ),
          AppConfirmButton(
            onTap: (_controller.text.trim().isEmpty || _chosenIcon == null)
                ? null
                : () => Navigator.pop(context, {
                  'name': _controller.text.trim(),
                  'icon': _chosenIcon
            }),
          )
        ]
    );
  }
}
