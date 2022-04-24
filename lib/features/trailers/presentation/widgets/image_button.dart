import 'package:movie_trailer/helpers/helper.dart';
import 'package:movie_trailer/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    required this.text,
    required this.onPress,
    required this.buttonColor,
    this.iconName,
  }) : super(key: key);

  final String text;
  final String buttonColor;
  final VoidCallback onPress;
  final String? iconName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconName == null
                      ? Container()
                      : Helpers.getImage(iconName!, width: mediumLogoSize),
                  SizedBox(width: 10),
                  Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: Colors.yellow,
                    child: Text(
                      text,
                      style: GoogleFonts.tomorrow(
                        color: Colors.black,
                        fontSize: mediumTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          onPress();
        },
      ),
    );
  }
}
