import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:mon/common/common.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:mon/utils/user_profile.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/widgets/menu/menu_widget.dart';
import 'package:mon/providers/localization.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/theme/fonts.dart';

class MoreScreen extends MBStatefulWidget  {
  static String get id {
    const Type type = MoreScreen;
    return '$type';
  }

  const MoreScreen({Key? key}) : super(key: key);

  @override
  MBState<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends MBState<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Localization>(context, listen: true).languages;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        runSpacing: 15,
        children: [
          if (UserProfile.shared.isUserLoggedIn)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MBSizedBox(
                    width: 60,
                    aspectRatio: 1,
                    child: MBContainer(
                        radius: 30,
                        shadowColor: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 1,
                        shadowOffset: const Offset(0, 0),
                        child: MBCircleImage(
                            "general/ic_user_empty.svg".image_,
                            width: 60))),
                16.ws,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MBText(
                        UserProfile.shared.currentUser?.firstName != null && UserProfile.shared.currentUser?.lastName != null ? "${UserProfile.shared.currentUser?.firstName ?? ""} ${UserProfile.shared.currentUser?.lastName ?? ""}" : "Valued customer",
                        fontWeight: AppFonts.bold,
                        textAlign: TextAlign.justify,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                      MBText(
                        UserProfile.shared.currentUser?.email ?? "",
                        fontWeight: AppFonts.regular,
                        textAlign: TextAlign.justify,
                        color: AppColors.gray_500,
                        fontSize: 12,
                      )
                    ],
                  ),
                ),
                MBButton(
                  onPressed: () {
                    // push(EditProfileScreen());
                  },
                  color: AppColors.black,
                  icon: const Icon(Icons.edit_note),
                )
              ],
            ),
          if (UserProfile.shared.isUserLoggedIn) const Divider(),
          ...[
            MenuOptions.notifications,
            MenuOptions.languages,
            MenuOptions.aboutUs,
            MenuOptions.privacyPolicy,
            MenuOptions.termsAndConditions,
            MenuOptions.login
          ].map((item) => MenuWidget(object: item))
        ],
      ),
    );
  }
}
