import 'package:flutter/material.dart';

import 'bottom_navy_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    required this.selectedBottomIndex,
    required this.changeBottomPageIndex,
  }) : super(key: key);

  final int selectedBottomIndex;
  final Function(int) changeBottomPageIndex;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      backgroundColor: Colors.white,
      selectedIndex: widget.selectedBottomIndex,
      showElevation: true,
      curve: Curves.easeInBack,
      onItemSelected: (index) => widget.changeBottomPageIndex(index),
      items: [
        BottomNavyBarItem(
          icon: Icons.movie,
          title: 'Trailers',
        ),
        BottomNavyBarItem(
          icon: Icons.perm_identity_outlined,
          title: 'User',
        ),
      ],
    );
  }
}
