import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

class ScreenSize {
  static double width = SizeConfig.screenWidth;
  static double height = SizeConfig.screenHeight;
}

class Sizes {
  static double scale = 4;
  static double get tny => scale * 1;
  static double get sm => scale * 2;
  static double get med => scale * 3;
  static double get base => scale * 4;
  static double get lg => scale * 5;
  static double get xl => scale * 6;
}

class Spacing {
  static Widget get verticalSpacingTny => SizedBox(
        height: Sizes.tny,
      );
  static Widget get verticalSpacingSm => SizedBox(
        height: Sizes.sm,
      );
  static Widget get verticalSpacingMed => SizedBox(
        height: Sizes.med,
      );
  static Widget get verticalSpacing => SizedBox(
        height: Sizes.base,
      );
  static Widget get verticalSpacingLg => SizedBox(
        height: Sizes.lg,
      );
  static Widget get verticalSpacingXl => SizedBox(
        height: Sizes.xl,
      );

  static Widget get horizontalSpacingTny => SizedBox(
        width: Sizes.tny,
      );
  static Widget get horizontalSpacingSm => SizedBox(
        width: Sizes.sm,
      );
  static Widget get horizontalSpacingMed => SizedBox(
        width: Sizes.med,
      );
  static Widget get horizontalSpacing => SizedBox(
        width: Sizes.base,
      );
  static Widget get horizontalSpacingLg => SizedBox(
        width: Sizes.lg,
      );
  static Widget get horizontalSpacingXl => SizedBox(
        width: Sizes.xl,
      );
}

class Corners {
  static Radius tnyRadius = Radius.circular(Sizes.tny);
  static BorderRadius tnyBorder = BorderRadius.all(tnyRadius);
  static Radius smRadius = Radius.circular(Sizes.sm);
  static BorderRadius smBorder = BorderRadius.all(smRadius);
  static Radius medRadius = Radius.circular(Sizes.med);
  static BorderRadius medBorder = BorderRadius.all(medRadius);
  static Radius baseRadius = Radius.circular(Sizes.base);
  static BorderRadius baseBorder = BorderRadius.all(baseRadius);
  static Radius lgRadius = Radius.circular(Sizes.lg);
  static BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static Radius xlRadius = Radius.circular(Sizes.xl);
  static BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static Radius fullRadius = const Radius.circular(9999);
  static BorderRadius fullBorder = BorderRadius.all(fullRadius);
  static Radius customRadius(double radius) => Radius.circular(radius);
  static BorderRadius customBorder(Radius radius) => BorderRadius.all(radius);
}
