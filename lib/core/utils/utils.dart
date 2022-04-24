import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool get isIpad {
  var width = Get.width;
  var height = Get.height;
  var widthHeightRatio = width / height;
  var heightWidthRatio = width / height;

  return widthHeightRatio > 0.6 && widthHeightRatio < 1 ||
      heightWidthRatio > 0.6 && heightWidthRatio < 1;
}

List<BoxShadow> getShadow({bool isButton = false}) {
  var boxShadows = <BoxShadow>[];
  if (isButton) {
    boxShadows.add(
      BoxShadow(
        color: Colors.white,
        blurRadius: 3,
        spreadRadius: 3,
        offset: Offset(2, -2),
      ),
    );
  }

  boxShadows.add(
    BoxShadow(
      color: Colors.grey.withOpacity(0.3),
      blurRadius: 3,
      spreadRadius: 3,
      offset: Offset(2, 2),
    ),
  );

  return boxShadows;
}

void runAfterDurationZero(VoidCallback callback) {
  Future.delayed(Duration.zero, callback);
}
