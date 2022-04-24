import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_trailer/features/trailers/presentation/store/movie_store.dart';
import 'package:movie_trailer/helpers/helper.dart';
import 'package:movie_trailer/helpers/responsive_helper.dart';
import 'package:movie_trailer/main.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/rate_button.dart';
import 'custom_text_box.dart';

class TrailerHeader extends StatelessWidget {
  const TrailerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieStore = getIt<MovieStore>();
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 10.h,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/exit.png',
                        height: xlargeTextSize, width: xlargeTextSize),
                  ],
                ),
                onTap: () {
                  Helpers.onWillPop(context);
                },
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png',
                      height: xlargeTextSize, width: xlargeTextSize),
                  SizedBox(width: 5.w),
                  Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: Colors.yellow,
                    child: Text(
                      'Movie Trailers',
                      style: GoogleFonts.aladin(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: smallTextSize,
                      ),
                    ),
                  ),
                ],
              ),
              RateButton()
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: DateInput(
                        label: 'From',
                        hint: '2020-01-20',
                        onChange: (value) => movieStore.from = value,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      flex: 1,
                      child: DateInput(
                        label: 'To',
                        hint: '2022-01-20',
                        onChange: (value) => movieStore.to = value,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(top: 15.h),
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => movieStore.fetchWithFilter(),
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      child: Icon(
                        Icons.filter_alt,
                        color: Colors.black,
                        size: mediumSLogoSize,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class DateInput extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) onChange;

  const DateInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              label,
              style: TextStyle(
                fontSize: xXSmallTextSize,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
          ),
          CustomTextBox(
            label: Container(
              child: Text(
                hint,
                style: TextStyle(
                  fontSize: xXSmallTextSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
            ),
            textStyle: TextStyle(
              fontSize: xXSmallTextSize,
              color: Colors.black,
            ),
            borderColor: Colors.black,
            textInputType: TextInputType.number,
            contentPadding: EdgeInsets.only(left: 15.w, top: 10.h),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
