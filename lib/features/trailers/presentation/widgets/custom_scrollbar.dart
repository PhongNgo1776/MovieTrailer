import 'package:flutter/material.dart';

class CustomScrollbar extends StatelessWidget {
  const CustomScrollbar({
    Key? key,
    required this.child,
    required this.controller,
    this.horizontalPadding = 2,
    this.isAlwaysShown = true,
  }) : super(key: key);

  final Widget child;
  final double horizontalPadding;
  final ScrollController controller;
  final bool isAlwaysShown;

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      isAlwaysShown: isAlwaysShown,
      thumbColor: Colors.black54,
      thickness: 4,
      radius: Radius.circular(5),
      controller: controller,
      child: child,
    );
  }
}
