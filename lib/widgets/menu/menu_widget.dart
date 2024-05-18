import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:mon/common/base_container.dart';
import 'package:mon/common/base_image.dart';
import 'package:mon/common/base_text.dart';
import 'package:mon/common/widgets/base_mixin.dart';
import 'package:mon/screens/languages/languages_screen.dart';
import 'package:mon/screens/static_pages/static_pages_screen.dart';
import 'package:mon/utils/extensions/extensions.dart';
import 'package:mon/utils/user_profile.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/web_service/requests/auth_request.dart';

import 'package:mon/providers/auth.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/theme/fonts.dart';

class MenuWidget extends StatelessWidget with BaseMixin {
  final MenuOptions  object;

  static String get id {
    const Type type = MenuWidget;
    return '$type';
  }

  const MenuWidget({required this.object, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        switch (object) {
          case MenuOptions.notifications:
            //push(NotificationsScreen());
            break;
          case MenuOptions.languages:
            //push(NotificationsScreen());
            break;
          case MenuOptions.aboutUs:
            push(StaticPagesScreen(object: object));
            break;
          case MenuOptions.privacyPolicy:
            push(StaticPagesScreen(object: object));
            break;
          case MenuOptions.termsAndConditions:
            push(StaticPagesScreen(object: object));
            break;
          case MenuOptions.login:
          //  if(UserProfile.shared.isUserLoggedIn) {
          //    AuthRequest request = AuthRequest(route: AuthRoutes.logout);
          //    await Provider.of<Auth>(context,
          //        listen: false)
          //        .logout(request);
          //  } else {
          //    showModalBottomSheet(
          //      context: context,
          //      builder: (BuildContext context) {
          //        return LoginScreen();
          //      },
          //    );
             // showSheetBuilder(context, (context, scrollController) {
             //   return LoginScreen();
             // });
          //  }
            break;
        }
      },
      child: SizedBox(
        height: 35,
        child: Row(
          children: [
            MBContainer(
                color: AppColors.gray_200.withOpacity(0.6),
                radius: 8,
                padding: const EdgeInsets.all(8),
                width: 35,
                height: 35,
                child: MBImage(object.image, color: AppColors.black,
                    fit: BoxFit.contain)),
            16.ws,
            Expanded(
              child: MBText(
                object.title,
                fontWeight: AppFonts.bold,
                textAlign: TextAlign.justify,
                color: AppColors.black,
                fontSize: 16,
              ),
            ),
            Row(children: [
              if(object == MenuOptions.languages) MBText(
                UserProfile.shared.isRTL ? localization.arabic : localization.english,
                fontWeight: AppFonts.regular,
                textAlign: TextAlign.justify,
                color: AppColors.gray_700,
                fontSize: 14,
              ),
              16.ws,
              SizedBox(
                  width: 15,
                  child: MBImage(
                      UserProfile.shared.isRTL
                          ? "home/ic_left.svg".image_
                          : "home/ic_right.svg".image_,
                      fit: BoxFit.contain))
            ],),
          ],
        ),
      ),
    );
  }
}
