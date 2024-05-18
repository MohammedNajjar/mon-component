import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mon/common/base_container.dart';
import 'package:mon/common/tab_bar/base_tab_bar_data.dart';
import 'package:mon/theme/colors.dart';
import 'package:mon/utils/Logger.dart';

class MBTabBarScreen extends StatefulWidget {
  final List<BaseTabBarData> tabs;
  final int? selectedPageIndex;
  final bool isScrollable;
  final EdgeInsetsGeometry? padding;
  final Color? indicatorColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry indicatorPadding;
  final Decoration? indicator;
  final bool automaticIndicatorColorAdjustment;
  final TabBarIndicatorSize? indicatorSize;
  final Color? dividerColor;
  final Color? labelColor;
  final Color? tabBarBackgroundColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final TextStyle? unselectedLabelStyle;
  final MaterialStateProperty<Color?>? overlayColor;
  final DragStartBehavior dragStartBehavior;
  final MouseCursor? mouseCursor;
  final bool? enableFeedback;
  final ValueChanged<int>? onTap;
  final ScrollPhysics? physics;
  final InteractiveInkFeatureFactory? splashFactory;
  final BorderRadius? splashBorderRadius;

  const MBTabBarScreen({
    required this.tabs,
    this.selectedPageIndex,
    this.isScrollable = false,
    this.padding,
    this.tabBarBackgroundColor = AppColors.primaryColor,
    this.indicatorColor = AppColors.primaryColor,
    this.automaticIndicatorColorAdjustment = true,
    this.indicatorWeight = 5.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize = TabBarIndicatorSize.tab,
    this.dividerColor,
    this.labelColor = AppColors.white,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.overlayColor,
    this.mouseCursor,
    this.enableFeedback,
    this.onTap,
    this.physics,
    this.splashFactory,
    this.splashBorderRadius,
    super.key});

  @override
  State<MBTabBarScreen> createState() => _MBTabBarScreenState();
}

class _MBTabBarScreenState extends State<MBTabBarScreen>
    with AutomaticKeepAliveClientMixin<MBTabBarScreen>, SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late List<BaseTabBarData> _tabs;
  int _selectedPageIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabs = widget.tabs;
    _selectedPageIndex = widget.selectedPageIndex ?? 0;
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MBContainer(
          color: widget.tabBarBackgroundColor,
          child: TabBar(
            isScrollable: widget.isScrollable,
            padding: widget.padding,
            indicatorColor: widget.indicatorColor,
            automaticIndicatorColorAdjustment: widget.automaticIndicatorColorAdjustment,
            indicatorWeight: widget.indicatorWeight,
            indicatorPadding: widget.indicatorPadding,
            indicator: widget.indicator,
            indicatorSize: widget.indicatorSize,
            dividerColor: widget.dividerColor,
            labelColor: widget.labelColor,
            labelStyle: widget.labelStyle,
            labelPadding: widget.labelPadding,
            unselectedLabelColor: widget.unselectedLabelColor,
            unselectedLabelStyle: widget.unselectedLabelStyle,
            dragStartBehavior: widget.dragStartBehavior,
            overlayColor: widget.overlayColor,
            mouseCursor: widget.mouseCursor,
            enableFeedback: widget.enableFeedback,
            onTap: widget.onTap,
            physics: widget.physics,
            splashFactory: widget.splashFactory,
            splashBorderRadius: widget.splashBorderRadius,
            tabs: _tabs
                .map((item) => Tab(
              text: item.title,
              icon: item.icon,
            ))
                .toList(),
            controller: _tabController,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _tabs.map((item) => item.body).toList(),
          ),
        )
      ],
    );
  }
} 