import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mon/common/widgets/base_mixin.dart';
import 'package:mon/utils/extensions/extensions.dart';

import '../theme/colors.dart';
import 'base_image.dart';
import 'base_text.dart';

class MBEmptyDataWidget extends StatelessWidget with BaseMixin {

  static String get id {
    const Type type = MBEmptyDataWidget;
    return '$type';
  }

  const MBEmptyDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          MBImage("general/ic_empty_state.svg".image_),
          MBText(
            localization.noDataToShow,
            color: AppColors.grey,
          )
        ],
      ),
    );
  }
}
