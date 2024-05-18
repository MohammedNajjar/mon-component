import 'package:mon/utils/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:mon/utils/extensions/extensions.dart';

class AppColors {
  // static const Color white = Color(0xFFFFFFFF);
  // static const Color black = Color(0xFF000000);

  static MaterialColor get primary => AppColors.primary_900.generateMaterialColor();

  static const Color darkBackground   = Color(0xFF1A191C);
  static const Color primaryColor     = Color(0xffEFC610);
  static const Color purple           = Color(0xff444BD3);
  static const Color white            = Color(0xffFFFFFF);
  static const Color black            = Color(0xff000000);
  static const Color red              = Color(0xffEF4444);
  static const Color grey             = Colors.grey;
  static const Color green            = Colors.green;

  static const Color neutrals_25      = Color(0xFFffffff);
  static const Color neutrals_50      = Color(0xFFF9F9FB);
  static const Color neutrals_100     = Color(0xffF3F3F6);
  static const Color neutrals_200     = Color(0xffE5E5EB);
  static const Color neutrals_300     = Color(0xffBCBCC5);
  static const Color neutrals_400     = Color(0xff9D9CAF);
  static const Color neutrals_500     = Color(0xff6C6B80);
  static const Color neutrals_600     = Color(0xff4C4B63);
  static const Color neutrals_700     = Color(0xff383751);
  static const Color neutrals_800     = Color(0xff201F37);
  static const Color neutrals_900     = Color(0xff121127);

  static const Color primary_50       = Color(0xFFfdf9e7);
  static const Color primary_100      = Color(0xFFfcf4cf);
  static const Color primary_200      = Color(0xfff9e89f);
  static const Color primary_300      = Color(0xfff5dd70);
  static const Color primary_400      = Color(0xfff2d140);
  static const Color primary_500      = Color(0xffEFC610);
  static const Color primary_600      = Color(0xffd7b20e);
  static const Color primary_700      = Color(0xffa78b0b);
  static const Color primary_800      = Color(0xff604f06);
  static const Color primary_900      = Color(0xff302803);

  static const Color gray_50          = Color(0xFFFAFAFA);
  static const Color gray_100         = Color(0xFFF5F5F5);
  static const Color gray_200         = Color(0xffEEEEEE);
  static const Color gray_300         = Color(0xffE0E0E0);
  static const Color gray_400         = Color(0xffBDBDBD);
  static const Color gray_500         = Color(0xff9E9E9E);
  static const Color gray_600         = Color(0xff757575);
  static const Color gray_700         = Color(0xff616161);
  static const Color gray_800         = Color(0xff424242);
  static const Color gray_900         = Color(0xff212121);

  static const Color red_50           = Color(0xFFFFEBEE);
  static const Color red_100          = Color(0xFFFFCDD2);
  static const Color red_200          = Color(0xFFEF9A9A);
  static const Color red_300          = Color(0xFFE57373);
  static const Color red_400          = Color(0xFFEF5350);
  static const Color red_500          = Color(0xFFF44336);
  static const Color red_600          = Color(0xFFE53935);
  static const Color red_700          = Color(0xFFD32F2F);
  static const Color red_800          = Color(0xFFC62828);
  static const Color red_900          = Color(0xFFB71C1C);

  static const Color pink_50          = Color(0xFFFCE4EC);
  static const Color pink_100         = Color(0xFFF8BBD0);
  static const Color pink_200         = Color(0xFFF48FB1);
  static const Color pink_300         = Color(0xFFF06292);
  static const Color pink_400         = Color(0xFFEC407A);
  static const Color pink_500         = Color(0xFFE91E63);
  static const Color pink_600         = Color(0xFFD81B60);
  static const Color pink_700         = Color(0xFFC2185B);
  static const Color pink_800         = Color(0xFFAD1457);
  static const Color pink_900         = Color(0xFF880E4F);

  static const Color purple_50        = Color(0xFFF3E5F5);
  static const Color purple_100       = Color(0xFFE1BEE7);
  static const Color purple_200       = Color(0xFFCE93D8);
  static const Color purple_300       = Color(0xFFBA68C8);
  static const Color purple_400       = Color(0xFFAB47BC);
  static const Color purple_500       = Color(0xFF9C27B0);
  static const Color purple_600       = Color(0xFF8E24AA);
  static const Color purple_700       = Color(0xFF7B1FA2);
  static const Color purple_800       = Color(0xFF6A1B9A);
  static const Color purple_900       = Color(0xFF4A148C);

  static const Color indigo_50        = Color(0xFFE8EAF6);
  static const Color indigo_100       = Color(0xFFC5CAE9);
  static const Color indigo_200       = Color(0xFF9FA8DA);
  static const Color indigo_300       = Color(0xFF7986CB);
  static const Color indigo_400       = Color(0xFF5C6BC0);
  static const Color indigo_500       = Color(0xFF3F51B5);
  static const Color indigo_600       = Color(0xFF3949AB);
  static const Color indigo_700       = Color(0xFF303F9F);
  static const Color indigo_800       = Color(0xFF283593);
  static const Color indigo_900       = Color(0xFF1A237E);

  static const Color deepPurple_50   = Color(0xFFEDE7F6);
  static const Color deepPurple_100  = Color(0xFFD1C4E9);
  static const Color deepPurple_200  = Color(0xFFB39DDB);
  static const Color deepPurple_300  = Color(0xFF9575CD);
  static const Color deepPurple_400  = Color(0xFF7E57C2);
  static const Color deepPurple_500  = Color(0xFF673AB7);
  static const Color deepPurple_600  = Color(0xFF5E35B1);
  static const Color deepPurple_700  = Color(0xFF512DA8);
  static const Color deepPurple_800  = Color(0xFF4527A0);
  static const Color deepPurple_900  = Color(0xFF311B92);

  static const Color green_50         = Color(0xFFE8F5E9);
  static const Color green_100        = Color(0xFFC8E6C9);
  static const Color green_200        = Color(0xFFA5D6A7);
  static const Color green_300        = Color(0xFF81C784);
  static const Color green_400        = Color(0xFF66BB6A);
  static const Color green_500        = Color(0xFF4CAF50);
  static const Color green_600        = Color(0xFF43A047);
  static const Color green_700        = Color(0xFF388E3C);
  static const Color green_800        = Color(0xFF2E7D32);
  static const Color green_900        = Color(0xFF1B5E20);

  static const Color yellow_50       = Color(0xFFFFFDE7);
  static const Color yellow_100      = Color(0xFFFFF9C4);
  static const Color yellow_200      = Color(0xFFFFF59D);
  static const Color yellow_300      = Color(0xFFFFF176);
  static const Color yellow_400      = Color(0xFFFFEE58);
  static const Color yellow_500      = Color(0xFFFFEB3B);
  static const Color yellow_600      = Color(0xFFFDD835);
  static const Color yellow_700      = Color(0xFFFBC02D);
  static const Color yellow_800      = Color(0xFFF9A825);
  static const Color yellow_900      = Color(0xFFF57F17);

  static const Color lightBlue_50      = Color(0xFFe1f5fe);
  static const Color lightBlue_100     = Color(0xFFb3e5fc);
  static const Color lightBlue_200     = Color(0xFF81d4fa);
  static const Color lightBlue_300     = Color(0xFF4fc3f7);
  static const Color lightBlue_400     = Color(0xFF29b6f6);
  static const Color lightBlue_500     = Color(0xFF03a9f4);
  static const Color lightBlue_600     = Color(0xFF039be5);
  static const Color lightBlue_700     = Color(0xFF0288d1);
  static const Color lightBlue_800     = Color(0xFF0277bd);
  static const Color lightBlue_900     = Color(0xFF01579b);

  static const Color blue_50            = Color(0xFFe3f2fd);
  static const Color blue_100           = Color(0xFFbbdefb);
  static const Color blue_200           = Color(0xFF90caf9);
  static const Color blue_300           = Color(0xFF64b5f6);
  static const Color blue_400           = Color(0xFF42a5f5);
  static const Color blue_500           = Color(0xFF2196f3);
  static const Color blue_600           = Color(0xFF1e88e5);
  static const Color blue_700           = Color(0xFF1976d2);
  static const Color blue_800           = Color(0xFF1565c0);
  static const Color blue_900           = Color(0xFF0d47a1);

  static const Color cyan_50            = Color(0xFFe0f7fa);
  static const Color cyan_100           = Color(0xFFb2ebf2);
  static const Color cyan_200           = Color(0xFF80deea);
  static const Color cyan_300           = Color(0xFF4dd0e1);
  static const Color cyan_400           = Color(0xFF26c6da);
  static const Color cyan_500           = Color(0xFF00bcd4);
  static const Color cyan_600           = Color(0xFF00acc1);
  static const Color cyan_700           = Color(0xFF0097a7);
  static const Color cyan_800           = Color(0xFF00838f);
  static const Color cyan_900           = Color(0xFF006064);

  static const Color teal_50            = Color(0xFFe0f2f1);
  static const Color teal_100           = Color(0xFFb2dfdb);
  static const Color teal_200           = Color(0xFF80cbc4);
  static const Color teal_300           = Color(0xFF4db6ac);
  static const Color teal_400           = Color(0xFF26a69a);
  static const Color teal_500           = Color(0xFF009688);
  static const Color teal_600           = Color(0xFF00897b);
  static const Color teal_700           = Color(0xFF00796b);
  static const Color teal_800           = Color(0xFF00695c);
  static const Color teal_900           = Color(0xFF004d40);

  static const Color lightGreen_50      = Color(0xFFf1f8e9);
  static const Color lightGreen_100     = Color(0xFFdcedc8);
  static const Color lightGreen_200     = Color(0xFFc5e1a5);
  static const Color lightGreen_300     = Color(0xFFaed581);
  static const Color lightGreen_400     = Color(0xFF9ccc65);
  static const Color lightGreen_500     = Color(0xFF8bc34a);
  static const Color lightGreen_600     = Color(0xFF7cb342);
  static const Color lightGreen_700     = Color(0xFF689f38);
  static const Color lightGreen_800     = Color(0xFF558b2f);
  static const Color lightGreen_900     = Color(0xFF33691e);

  static const Color lime_50            = Color(0xFFf9fbe7);
  static const Color lime_100           = Color(0xFFf0f4c3);
  static const Color lime_200           = Color(0xFFe6ee9c);
  static const Color lime_300           = Color(0xFFdce775);
  static const Color lime_400           = Color(0xFFd4e157);
  static const Color lime_500           = Color(0xFFcddc39);
  static const Color lime_600           = Color(0xFFc0ca33);
  static const Color lime_700           = Color(0xFFafb42b);
  static const Color lime_800           = Color(0xFF9e9d24);
  static const Color lime_900           = Color(0xFF827717);

  static const Color brown_50           = Color(0xFFefebe9);
  static const Color brown_100          = Color(0xFFd7ccc8);
  static const Color brown_200          = Color(0xFFbcaaa4);
  static const Color brown_300          = Color(0xFFa1887f);
  static const Color brown_400          = Color(0xFF8d6e63);
  static const Color brown_500          = Color(0xFF795548);
  static const Color brown_600          = Color(0xFF6d4c41);
  static const Color brown_700          = Color(0xFF5d4037);
  static const Color brown_800          = Color(0xFF4e342e);
  static const Color brown_900          = Color(0xFF3e2723);


  static const Color blueGray_50        = Color(0xFFeceff1);
  static const Color blueGray_100       = Color(0xFFcfd8dc);
  static const Color blueGray_200       = Color(0xFFb0bec5);
  static const Color blueGray_300       = Color(0xFF90a4ae);
  static const Color blueGray_400       = Color(0xFF78909c);
  static const Color blueGray_500       = Color(0xFF607d8b);
  static const Color blueGray_600       = Color(0xFF546e7a);
  static const Color blueGray_700       = Color(0xFF455a64);
  static const Color blueGray_800       = Color(0xFF37474f);
  static const Color blueGray_900       = Color(0xFF263238);

  static const Color indigo2_50          = Color(0xFFF6F6FE);
  static const Color indigo2_300         = Color(0xff878DE8);
  static const Color indigo2_500         = Color(0xff444BD3);

  static const Color red2_50             = Color(0xFFFFF8F8);
  static const Color red2_300            = Color(0xffFCA5A5);
  static const Color red2_500            = Color(0xffEF4444);

  static const Color green2_50           = Color(0xFFF3FDF9);
  static const Color green2_300          = Color(0xff6EE7B7);
  static const Color green2_500          = Color(0xff10B981);


static const Color secondary            = Colors.blueAccent;
static const Color darkGrey             = Color(0xFFC4C4C4);

  static const Color transparent        = Colors.transparent;
  static const Color blue               = Color(0xff2785FC);
  static Color backgroundBlue           = const Color(0xffD3D3D3).withOpacity(0.12);

  //Color(0xff2785FC).withOpacity(0.06);
  static const Color cardBackground     = Color(0xfff9f9f9);
  static const Color blueAccent         = Colors.blueAccent;
  static const Color lightBlue          = Colors.lightBlue;

  //static Color dropDownBlue = Color.fromRGBO(39, 133, 252, 0.85);
  static Color dropDownBlue             = Colors.lightBlue.withOpacity(0.85);
  static Color activeCardColor          = Colors.lightBlue.withOpacity(0.15);

  // AppBarColors
  static Color get appBarBackground => UserProfile.shared.isDark ? Colors.black : AppColors.primaryColor;

  static Color get appBarTitle => UserProfile.shared.isDark ? AppColors.white : AppColors.white;

  static Color get appBarIcon => UserProfile.shared.isDark ? AppColors.white : AppColors.white;

  static Color get scaffoldBackground => UserProfile.shared.isDark ? AppColors.darkBackground : AppColors.neutrals_50;

// ************************ Start Text Field Input ************************ //
  static const Color inputTextColor         = AppColors.black;
  // static const Color inputLabelTextColor    = Colors.grey;//Color(0xFF878de8);
  static const Color inputErrorTextColor    = Color(0xFF878de8);
  static const Color inputBorderTextColor   = Color(0xff8f9199);
// ************************* End Text Field Input ************************* //


}
