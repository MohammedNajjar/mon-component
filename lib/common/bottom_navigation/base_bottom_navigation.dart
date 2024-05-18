import 'package:mon/common/common.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/theme/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_bottom_navigation_data.dart';

class MBBottomNavigationScreen extends MBStatefulWidget {
  final List<BaseBottomNavigationData> pages;
  final Widget? bottomNavigationBar;
  final int? selectedPageIndex;
  final ValueChanged<int>? onTap;
  final double? elevation;
  final BottomNavigationBarType? type;
  final Color? fixedColor;
  final Color? selectedIconColor;
  final Color? backgroundColor;
  final double? iconSize;
  final double? unselectedFontSize;
  final double? selectedFontSize;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final IconThemeData? selectedIconTheme;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final bool? showSelectedLabels;
  final bool? showUnselectedLabels;
  final bool? useLegacyColorScheme;
  final BottomNavigationBarLandscapeLayout? landscapeLayout;
  final bool? hideAppBar;

  static String get id {
    const Type type = MBBottomNavigationScreen;
    return '$type';
  }

  const MBBottomNavigationScreen({
    required this.pages,
    this.bottomNavigationBar,
    this.selectedPageIndex,
    this.onTap,
    this.elevation,
    this.type,
    this.fixedColor,
    this.backgroundColor,
    this.selectedIconColor,
    this.selectedItemColor,
    this.iconSize = 24.0,
    this.unselectedItemColor,
    this.selectedIconTheme,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.landscapeLayout,
    this.useLegacyColorScheme = true,
    this.hideAppBar = false,
    Key? key})
      : super(key: key);

  @override
  State<MBBottomNavigationScreen> createState() => _MBBottomNavigationScreenState();
}

class _MBBottomNavigationScreenState extends State<MBBottomNavigationScreen> {
  late List<BaseBottomNavigationData> _pages;

  @override
  void initState() {
    _pages = widget.pages;
    _selectedPageIndex = widget.selectedPageIndex ?? 0;
    super.initState();
  }

  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MBScaffold(
      title: _pages[_selectedPageIndex].title,
      hideAppBar: widget.hideAppBar,
      appBar: AppBar(
        title: MBText(_pages[_selectedPageIndex].title),
      ),
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _pages.map((item) => item.screen).toList(),
      ),
      bottomNavigationBar: widget.bottomNavigationBar ??
          BottomNavigationBar(
            currentIndex: _selectedPageIndex,
            onTap: (index) {
              setState(() {
                _selectedPageIndex = index;
              });
              if(widget.onTap != null) {
                widget.onTap!(index);
              }
            },
            backgroundColor: widget.backgroundColor ?? Colors.white,
            unselectedItemColor: widget.unselectedItemColor ?? AppColors.neutrals_600,
            selectedItemColor: widget.selectedItemColor ?? AppColors.black,
            selectedLabelStyle: widget.selectedLabelStyle ?? const TextStyle(
              fontSize: 14,
              fontWeight: AppFonts.bold,
            ),
            unselectedLabelStyle: widget.unselectedLabelStyle ?? const TextStyle(
              fontWeight: AppFonts.regular,
            ),
            selectedIconTheme: widget.selectedIconTheme ?? IconThemeData(
              color: widget.selectedIconColor ?? AppColors.primary_500, // set the color of the selected icon here
            ),
            elevation: widget.elevation,
            type: widget.type,
            fixedColor: widget.fixedColor,
            iconSize: widget.iconSize ?? 24.0,
            selectedFontSize: widget.selectedFontSize ?? 14.0,
            unselectedFontSize: widget.unselectedFontSize ?? 12.0,
            showSelectedLabels: widget.showSelectedLabels,
            showUnselectedLabels : widget.showUnselectedLabels,
            landscapeLayout: widget.landscapeLayout,
            useLegacyColorScheme: widget.useLegacyColorScheme ?? true,
            items: _pages.map((item) => BottomNavigationBarItem(
                icon: item.icon ?? Icon(Icons.category), label: item.title)).toList(),
          ),
    );

    //   DefaultTabController(
    //   length: 2,
    //   initialIndex: 0,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const  Text('Meals'),
    //       bottom: const TabBar(
    //         indicatorColor: Colors.white,
    //         tabs: [
    //         Tab(icon: Icon(Icons.category), text: 'Category',),
    //         Tab(icon: Icon(Icons.favorite), text: 'Favorite',)
    //       ],),
    //     ),
    //     body: const  TabBarView(
    //       children: [
    //       CategoriesScreen(),
    //       FavoritesScreen(),
    //     ],),
    //   ),
    // );
  }
}
