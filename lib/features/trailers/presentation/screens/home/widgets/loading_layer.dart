import 'package:flutter/material.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({
    Key? key,
    this.alignment = Alignment.bottomCenter,
  }) : super(key: key);

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: Container(
        alignment: alignment,
        padding: EdgeInsets.only(bottom: 30),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
