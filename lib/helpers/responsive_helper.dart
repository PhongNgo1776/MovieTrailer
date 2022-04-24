import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_trailer/core/utils/utils.dart';

class ResponsiveHelper {}

double get ipadIconSize => 1.sw / 18;
double get ipadFontSize => 1.sw / 24;

// Some common sizes
double get menuSpaceSize => isIpad ? 30 : 10;

// TEXT
double get xXlargeTextSize => isIpad ? ipadFontSize * 1.3 : 40.sp;
double get xlargeTextSize => isIpad ? ipadFontSize * 1.2 : 30.sp;
double get largeTextSize => isIpad ? ipadFontSize * 1.1 : 25.sp;
double get mediumTextSize => isIpad ? ipadFontSize : 22.sp;
double get smallTextSize => isIpad ? ipadFontSize * 0.8 : 20.sp;
double get xSSmallTextSize => isIpad ? ipadFontSize * 0.6 : 18.sp;
double get xSmallTextSize => isIpad ? ipadFontSize * 0.4 : 15.sp;
double get xXSmallTextSize => isIpad ? ipadFontSize * 0.3 : 13.sp;
double get xXXSmallTextSize => isIpad ? ipadFontSize * 0.2 : 10.sp;
double get xXXXSmallTextSize => isIpad ? ipadFontSize * 0.1 : 7.sp;

// IMAGE
double get xXLargeLogoSize => isIpad ? ipadIconSize * 1.6 : 45.sp;
double get xLargeLogoSize => isIpad ? ipadIconSize * 1.5 : 40.sp;
double get largeLogoSize => isIpad ? ipadIconSize * 1.2 : 35.sp;
double get mediumLogoSize => isIpad ? ipadIconSize : 30.sp;
double get mediumSLogoSize => isIpad ? ipadIconSize * 0.9 : 25.sp;
double get smallLogoSize => isIpad ? ipadIconSize * 0.8 : 20.sp;
double get xSmallLogoSize => isIpad ? ipadIconSize * 0.6 : 16.sp;
