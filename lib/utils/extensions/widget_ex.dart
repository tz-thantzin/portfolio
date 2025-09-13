import 'package:flutter/cupertino.dart';

import '../../presentations/configs/sizes.dart';

const double _tiny = s4;
const double _small = s8;
const double _medium = s16;
const double _large = s24;
const double _massive = s32;
const double _enormous = s40;

extension WidgetEx on Widget {
  SizedBox get horizontalSpaceTiny => SizedBox(width: _tiny);
  SizedBox get horizontalSpaceSmall => SizedBox(width: _small);
  SizedBox get horizontalSpaceMedium => SizedBox(width: _medium);
  SizedBox get horizontalSpaceLarge => SizedBox(width: _large);
  SizedBox get horizontalSpaceMassive => SizedBox(width: _massive);
  SizedBox get horizontalSpaceEnormous => SizedBox(width: _enormous);

  SizedBox get verticalSpaceTiny => SizedBox(height: _tiny);
  SizedBox get verticalSpaceSmall => SizedBox(height: _small);
  SizedBox get verticalSpaceMedium => SizedBox(height: _medium);
  SizedBox get verticalSpaceLarge => SizedBox(height: _large);
  SizedBox get verticalSpaceMassive => SizedBox(height: _massive);
  SizedBox get verticalSpaceEnormous => SizedBox(height: _enormous);
}
