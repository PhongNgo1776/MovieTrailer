import 'package:movie_trailer/helpers/flare_endless_controller.dart';
import 'package:movie_trailer/helpers/responsive_helper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/widgets.dart';

class RateButton extends StatelessWidget {
  RateButton({
    Key? key,
  }) : super(key: key);

  final FlareEndlessController _starLoopController =
      FlareEndlessController('Untitled', 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: xLargeLogoSize,
          height: xLargeLogoSize,
          child: FlareActor(
            'assets/images/star.flr',
            alignment: Alignment.center,
            controller: _starLoopController,
          )),
      onTap: () {},
    );
  }
}
