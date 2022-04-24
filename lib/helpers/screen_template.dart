import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_trailer/main.dart';

import '../core/services/network_service.dart';

class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({
    Key? key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
  }) : super(key: key);

  final AppBar? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  _ScreenTemplateState createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  NetworkService networkService = getIt<NetworkService>();
  bool isConnected = false;

  @override
  void initState() {
    isConnected = networkService.isConnected;
    networkService.counterStream.listen((_isConnected) {
      setState(() => isConnected = _isConnected);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: widget.appBar,
        body: Stack(
          children: [
            widget.body,
            Observer(builder: (context) {
              return Visibility(
                visible: !isConnected,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black87,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 0.7.sw,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'No Internet! \nPlease connect the internet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
    );
  }
}
