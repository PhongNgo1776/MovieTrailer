import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_trailer/helpers/responsive_helper.dart';

class LoadingMessage extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlurLayerWrapper(),
        Container(
          key: ValueKey('LoadingIndicator'),
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                value: null,
                backgroundColor: Colors.white,
                strokeWidth: 5.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'Loading',
                    style: TextStyle(
                      fontSize: xSmallTextSize,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BlurLayerWrapper extends StatelessWidget {
  const BlurLayerWrapper({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.8, sigmaY: 1.8),
        child: Opacity(
          opacity: 0.85,
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
