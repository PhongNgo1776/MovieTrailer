import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'responsive_helper.dart';

const FAVORITE_DELIMITER = '__';
const NUM_QUESTIONS_PER_PAGE = 6;

class Helpers {
  static Random rnd = Random();

  static Image getImage(String imageName,
      {required double width, double? height}) {
    return Image.asset(
      'assets/images/$imageName.png',
      width: width,
      height: height,
    );
  }

  static navigateToGameScreen(BuildContext context, VoidCallback callback) {
    Navigator.pushNamed(context, '/game')
        .then((_) => Future.delayed(Duration(seconds: 1), () => callback()));
  }

  static Future<bool>? onWillPop(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Quit App ?',
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              decoration: TextDecoration.underline,
              decorationColor: Colors.red,
              decorationStyle: TextDecorationStyle.solid,
            )),
        content: Container(
            child: Text('Are you sure ?',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold))),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                decorationStyle: TextDecorationStyle.solid,
                shadows: [
                  Shadow(
                    color: Colors.greenAccent,
                    blurRadius: 10.0,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => exit(0),
            child: Text(
              'Yes',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.solid,
                shadows: [
                  Shadow(
                    color: Colors.greenAccent,
                    blurRadius: 10.0,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Future<bool>.value(false);
  }

  static BoxDecoration boxDecoration([Color? color]) {
    return BoxDecoration(
      color: color ?? Colors.yellow[100],
      border: Border.all(width: 1.0),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(1, 0.0), // 10% of the width, so there are ten blinds.
        colors: <Color>[
          color ?? Colors.white,
          color ?? Colors.grey[100]!,
        ], // red to yellow
        tileMode: TileMode.clamp, // repeats the gradient over the canvas
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          blurRadius: 2,
          spreadRadius: 2,
          offset: Offset(-1, -1),
        ),
        BoxShadow(
          color: Colors.black54,
          blurRadius: 2,
          spreadRadius: 2,
          offset: Offset(2, 2),
        )
      ],
      borderRadius: BorderRadius.all(Radius.circular(20.0) //
          ),
    );
  }

  static void backToHomeScreen(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  // static Widget getSegmentMenuBox({
  //   BuildContext context,
  //   String path,
  //   String imageLink,
  //   String label,
  //   int index,
  // }) {
  //   var appProvider = Provider.of<GameProvider>(context, listen: false);
  //   return GestureDetector(
  //     onTap: () {
  //       appProvider.currentSegmentIndex = index;
  //       Navigator.pushNamed(context, path);
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(bottom: 15.sp, right: 10.sp, left: 10.sp),
  //       alignment: Alignment.center,
  //       height: 0.1.sh,
  //       decoration: boxDecoration(),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Expanded(
  //             flex: 2,
  //             child: Container(
  //               alignment: Alignment.centerLeft,
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(20.sp),
  //                   bottomLeft: Radius.circular(20.sp),
  //                 ),
  //                 child: Image.network(
  //                   imageLink,
  //                   height: 0.1.sh,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 8,
  //             child: Text(
  //               label,
  //               style: TextStyle(
  //                 fontSize: xSSmallTextSize,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  static Widget getMenuBox({
    required BuildContext context,
    required String path,
    required String imageName,
    required String label,
    String imgType = 'png',
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, path);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
        margin: EdgeInsets.only(bottom: 5, right: 10, left: 10),
        alignment: Alignment.center,
        decoration: boxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(xXSmallTextSize),
              child: Image.asset(
                'assets/images/$imageName.$imgType',
                height: xLargeLogoSize,
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
