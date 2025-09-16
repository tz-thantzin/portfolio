import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../presentations/configs/constant_sizes.dart';

const double _tiny = s4;
const double _small = s8;
const double _medium = s16;
const double _large = s24;
const double _massive = s32;
const double _enormous = s40;

extension WidgetEx on Widget {
  SizedBox get horizontalSpaceTiny => SizedBox(width: _tiny.w);
  SizedBox get horizontalSpaceSmall => SizedBox(width: _small.w);
  SizedBox get horizontalSpaceMedium => SizedBox(width: _medium.w);
  SizedBox get horizontalSpaceLarge => SizedBox(width: _large.w);
  SizedBox get horizontalSpaceMassive => SizedBox(width: _massive.w);
  SizedBox get horizontalSpaceEnormous => SizedBox(width: _enormous.w);

  SizedBox get verticalSpaceTiny => SizedBox(height: _tiny.h);
  SizedBox get verticalSpaceSmall => SizedBox(height: _small.h);
  SizedBox get verticalSpaceMedium => SizedBox(height: _medium.h);
  SizedBox get verticalSpaceLarge => SizedBox(height: _large.h);
  SizedBox get verticalSpaceMassive => SizedBox(height: _massive.h);
  SizedBox get verticalSpaceEnormous => SizedBox(height: _enormous.h);
}
