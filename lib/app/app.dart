import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mon/providers/localization.dart';
import 'package:mon/web_service/constants.dart';
import 'package:mon/utils/user_profile.dart';
import 'package:mon/screens/home/home_screen.dart';
import 'package:mon/providers/theme.dart';
import 'package:mon/providers/auth.dart';
import 'package:mon/utils/Logger.dart';
import 'package:mon/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_manager.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));
    Logger.log(
        "UserProfile.shared.currentLanguage ${UserProfile.shared.currentLanguage}");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Localization()),
        // ChangeNotifierProvider(create: (_) => Cart()),
        // ChangeNotifierProvider(create: (_) => Orders()),
        // ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, themeChangeProvider, _) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                    title: Constants.appName,
                    navigatorKey: AppManager.navState,
                    localizationsDelegates: const [
                      //https://docs.flutter.dev/development/accessibility-and-localization/internationalization
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'), // English
                      Locale('ar'), // Spanish
                    ],
                    locale: Provider.of<Localization>(context, listen: true).locale,
                    builder: EasyLoading.init(),
                    theme:
                    createAppTheme(themeChangeProvider.isDark, context),
                    debugShowCheckedModeBanner: false,
                    useInheritedMediaQuery: true,
                    home: Consumer<Auth>(builder: (ctx, authData, _) {
                      return authData.isAuth ?  Home() : Home();
                    }),
                    routes: {
                      Home.id: (_) => Home(),
                      // '/': (_) => AuthScreen(), //InitialRoute
                      // '/': (_) => ProductsScreen(), //InitialRoute
                    });
              });
        },
      ),
    );
  }
}
