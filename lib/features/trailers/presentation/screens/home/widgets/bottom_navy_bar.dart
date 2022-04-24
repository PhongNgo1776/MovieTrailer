library bottom_navy_bar;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_trailer/helpers/responsive_helper.dart';

import 'movie_body_tab.dart';

/// A beautiful and animated bottom navigation.
/// The navigation bar use your current theme, but you are free to customize it.
class BottomNavyBar extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double containerHeight;
  final Curve curve;

  BottomNavyBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor = Colors.transparent,
    this.containerHeight = BOTTOM_NAVIGATION_HEIGHT,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor;

    return Container(
      width: double.infinity,
      height: containerHeight.h,
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () => onItemSelected(index),
            child: _ItemWidget(
              item: item,
              iconSize: iconSize.w,
              isSelected: index == selectedIndex,
              backgroundColor: bgColor,
              animationDuration: animationDuration,
              curve: curve,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconTheme(
          data: IconThemeData(
            size: item.iconSize.w,
            color: isSelected ? Colors.black : Colors.grey,
          ),
          child: Icon(
            item.icon,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5.w),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: xSSmallTextSize,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The BottomNavyBar's item. Used to configure each item of the navigation bar.
/// [icon] required. The widget on the left of this item.
/// [title] required. The widget on the right of this item.
class BottomNavyBarItem {
  final IconData icon;
  final String title;
  final double iconSize;

  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.iconSize = 20,
  });
}
