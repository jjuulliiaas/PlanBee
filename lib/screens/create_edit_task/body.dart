import 'package:flutter/material.dart';
import 'package:planbee/core/utils/app_padding.dart';

import 'components/details_card.dart';
import 'components/input_card.dart';

class CreateEditBody extends StatefulWidget {
  const CreateEditBody({super.key});

  @override
  State<CreateEditBody> createState() => _CreateEditBodyState();
}

class _CreateEditBodyState extends State<CreateEditBody> {
  final _key = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputCard(
                titleController: _titleController,
                descriptionController: _descriptionController,
              ),
              SizedBox(height: AppPadding.vertical(context),),
              DetailsCard(),
              
            ],
          )
      ),
    );
  }
}
