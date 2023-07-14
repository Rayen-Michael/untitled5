import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/modules/profile/controllers/edit_dob_controller.dart';
import '../../../../global_widgets/primary_filled_btn.dart';

class EditDOBView extends StatefulWidget {
  const EditDOBView({super.key});

  @override
  _EditDOBViewState createState() => _EditDOBViewState();
}

class _EditDOBViewState extends State<EditDOBView> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NxAppBar(
                  title: StringValues.birthDate,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() => GetBuilder<EditDOBController>(
    builder: (logic) => Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: Dimens.edgeInsetsHorizDefault,
          child: FocusScope(
            node: logic.focusNode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Dimens.boxHeight8,
                GestureDetector(
                  onTap: () async {
                    final date = await pickDate();
                    if (date == null) return;
                    setState(() => dateTime = date);
                    logic.dobTextController.text = '${dateTime.year}/${dateTime.month}/${dateTime.day}';
                  },
                  child: Container(
                    height: Dimens.fiftySix,
                    constraints:
                    BoxConstraints(maxWidth: Dimens.screenWidth),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: StringValues.dob,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.four),
                        ),
                        hintStyle: AppStyles.style14Normal.copyWith(
                          color: ColorValues.grayColor,
                        ),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.datetime,
                      style: AppStyles.style16Normal.copyWith(
                        color: Theme.of(Get.context!)
                            .textTheme
                            .bodyLarge!
                            .color,
                      ),
                      controller: logic.dobTextController,
                      enabled: false,
                      onEditingComplete: logic.focusNode.unfocus,
                    ),
                  ),
                ),
                Dimens.boxHeight40,
                NxFilledButton(
                  onTap: logic.updateDOB,
                  label: StringValues.save.toUpperCase(),
                  height: Dimens.fiftySix,
                ),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Future<DateTime?> pickDate() => showDatePicker(
    initialDate: dateTime,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    context: Get.context!,
  );
}
