import 'package:mon/theme/colors.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/app/app_manager.dart';
import 'package:mon/web_service/request_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin BaseMixin {
  Future<void> openMap(double latitude, double longitude) async {
    try {
      final coordinates = '$latitude,$longitude';
      final url =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      }
    } catch (e) {
      Logger.log('Error open map $e');
    }
  }

  AppLocalizations get localization {
    return AppLocalizations.of(AppManager.navState.currentContext!)!;
  }

  Future<void> showConfirmationDialog(BuildContext context, String title,
      String message, Function onOkPressed) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(localization.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(localization.oK),
              onPressed: () {
                onOkPressed();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future showSheetBuilder(BuildContext context, ScrollableWidgetBuilder builder,
      {isPadding = false}) async {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: AppColors.white,
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isDismissible: true,
      // barrierColor: barrierColor,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.70,
        //set this as you want
        maxChildSize: 0.92,
        //set this as you want
        minChildSize: 0.30,
        //set this as you want
        expand: false,
        snapSizes: const [
          0.30,
          0.35,
          0.4,
          0.45,
          0.5,
          0.55,
          0.6,
          0.65,
          0.7,
          0.75,
          0.8,
          0.85,
          0.9,
          0.92,
        ],
        snap: false,
        builder: builder,
      ),
    );
  }

  void snakeBar(String message,
      {TextAlign textAlign = TextAlign.start,
      int duration = 5,
      SnackBarAction? action,
      BuildContext? context}) {
    final buildContext = AppManager.navState.currentContext ?? context;
    if (buildContext == null) {
      Logger.log('Snake Bar context is null');
      return;
    }
    ScaffoldMessenger.of(buildContext!).showSnackBar(SnackBar(
      content: Text(message, textAlign: textAlign),
      duration: Duration(seconds: duration),
      action: action,
    ));
  }

  void pushById(String routeName, {Object? arguments, BuildContext? context}) {
    final buildContext = AppManager.navState.currentContext ?? context;
    if (buildContext == null) {
      Logger.log('Navigator context is null');
      return;
    }
    Navigator.of(buildContext!).pushNamed(routeName, arguments: arguments);
  }

  void push(Widget screen, {Object? arguments, BuildContext? context}) {
    final buildContext = AppManager.navState.currentContext ?? context;
    if (buildContext == null) {
      Logger.log('Navigator context is null');
      return;
    }
    Navigator.of(buildContext!)
        .push(MaterialPageRoute(builder: (context) => screen));
  }

  void pop({BuildContext? context}) {
    final buildContext = AppManager.navState.currentContext ?? context;
    if (buildContext == null) {
      Logger.log('Navigator context is null');
      return;
    }
    Navigator.of(buildContext!).pop();
  }
}
