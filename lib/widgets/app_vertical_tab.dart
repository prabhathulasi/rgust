import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

enum IndicatorSide { start, end }

class VerticalTabs extends StatefulWidget {
  final int initialIndex;
  final double tabsWidth;
  final double indicatorWidth;
  final IndicatorSide indicatorSide;
  final List<Tab> tabs;
  final List<Widget> contents;
  final TextDirection direction;
  final Color indicatorColor;
  final bool disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color selectedTabBackgroundColor;
  final Color tabBackgroundColor;
  final TextStyle selectedTabTextStyle;
  final TextStyle tabTextStyle;
  final Duration changePageDuration;
  final Curve changePageCurve;
  final Color tabsShadowColor;
  final double tabsElevation;
  final Function(int tabIndex)? onSelect;
  final Color? backgroundColor;
  final Widget? header;
  final Widget? footer;

  const VerticalTabs({
    Key? key,
    required this.tabs,
    required this.contents,
    this.tabsWidth = 200,
    this.indicatorWidth = 3,
    this.indicatorSide = IndicatorSide.end,
    this.initialIndex = 0,
    this.direction = TextDirection.ltr,
    this.indicatorColor = Colors.green,
    this.disabledChangePageFromContentView = false,
    this.contentScrollAxis = Axis.horizontal,
    this.selectedTabBackgroundColor = const Color(0x1100ff00),
    this.tabBackgroundColor = const Color(0xfff8f8f8),
    this.selectedTabTextStyle = const TextStyle(color: Colors.black),
    this.tabTextStyle = const TextStyle(color: Colors.black38),
    this.changePageCurve = Curves.easeInOut,
    this.changePageDuration = const Duration(milliseconds: 300),
    this.tabsShadowColor = Colors.black54,
    this.tabsElevation = 2.0,
    this.onSelect,
    this.header,
    this.footer,
    this.backgroundColor,
  })  : assert(tabs.length == contents.length),
        super(key: key);

  @override
  VerticalTabsState createState() => VerticalTabsState();
}

class VerticalTabsState extends State<VerticalTabs> with TickerProviderStateMixin {
  late int _selectedIndex;
  bool? _changePageByTapView;

  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<RelativeRect> rectAnimation;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = const NeverScrollableScrollPhysics();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    for (int i = 0; i < widget.tabs.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    
    // Handle initial URL and set the correct tab
    _handleInitialUrl();
    
    // Listen for URL changes
    window.onPopState.listen((event) {
      final path = window.location.pathname;
      final index = _getIndexFromPath(path!);
      if (index != null && index != _selectedIndex) {
        _selectTab(index);
      }
    });
  }

  void _handleInitialUrl() {
    final path = window.location.pathname;
    final index = _getIndexFromPath(path!) ?? widget.initialIndex;
    _selectTab(index);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? Theme.of(context).canvasColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  elevation: widget.tabsElevation,
                  shadowColor: widget.tabsShadowColor,
                  shape: const BeveledRectangleBorder(),
                  child: Container(
                    color: AppColors.colorc7e,
                    width: widget.tabsWidth,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: widget.header,
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.tabs.length,
                            itemBuilder: (context, index) {
                              Tab tab = widget.tabs[index];

                              Alignment alignment = Alignment.centerLeft;
                              if (widget.direction == TextDirection.rtl) {
                                alignment = Alignment.centerRight;
                              }

                              Widget child;
                              if (tab.child != null) {
                                child = tab.child!;
                              } else {
                                child = Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: <Widget>[
                                      if (tab.icon != null) ...[
                                        tab.icon!,
                                        const SizedBox(width: 5),
                                      ],
                                      if (tab.text != null) Expanded(
                                        child: Text(
                                          tab.text!,
                                          softWrap: true,
                                          style: _selectedIndex == index
                                              ? widget.selectedTabTextStyle
                                              : widget.tabTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              Color itemBGColor = widget.tabBackgroundColor;
                              if (_selectedIndex == index) {
                                itemBGColor = widget.selectedTabBackgroundColor;
                              }

                              return GestureDetector(
                                onTap: () {
                                  _changePageByTapView = true;
                                  setState(() {
                                    _selectTab(index);
                                  });
                                  pageController.jumpToPage(index);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: itemBGColor,
                                      borderRadius: BorderRadius.circular(15.sp),
                                    ),
                                    alignment: alignment,
                                    padding: const EdgeInsets.all(5),
                                    child: child,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        widget.footer ?? Container(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    pageSnapping: false,
                    physics: pageScrollPhysics,
                    onPageChanged: (index) {
                      if (_changePageByTapView == false || _changePageByTapView == null) {
                        _selectTab(index);
                      }
                      if (_selectedIndex == index) {
                        _changePageByTapView = null;
                      }
                      setState(() {});
                    },
                    controller: pageController,
                    itemCount: widget.contents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return widget.contents[index];
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectTab(int index) {
    String newUrl;
    switch (index) {
      case 0:
        newUrl = '/Dashboard';
        break;
      case 1:
        newUrl = '/Student';
        break;
      case 2:
        newUrl = '/Staff';
        break;
      case 3:
        newUrl = '/Faculty';
        break;
      case 4:
        newUrl = '/Department';
        break;
      case 5:
        newUrl = '/Fees';
        break;
      case 6:
        newUrl = '/Results';
        break;
      default:
        newUrl = '/Dashboard';
        break;
    }
    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].animateTo(double.parse("$index"));

    if (widget.onSelect != null) {
      widget.onSelect!(_selectedIndex);
    }
    window.history.pushState(null, '', newUrl);
  }

  int? _getIndexFromPath(String path) {
    switch (path) {
      case '/Dashboard':
        return 0;
      case '/Student':
        return 1;
      case '/Staff':
        return 2;
      case '/Faculty':
        return 3;
      case '/Department':
        return 4;
      case '/Fees':
        return 5;
      case '/Results':
        return 6;
      default:
        return null;
    }
  }
}
