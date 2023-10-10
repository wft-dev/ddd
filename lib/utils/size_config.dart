import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// Constant sizes to be used in the app (paddings, gaps, rounded corners etc.).
class Sizes {
  static const pIntN1 = -1;
  static const pInt0 = 0;
  static const pInt1 = 1;
  static const pInt3 = 3;
  static const pInt4 = 4;
  static const p01 = 0.1;
  static const p02 = 0.2;
  static const p03 = 0.3;
  static const p05 = 0.5;
  static const p06 = 0.6;
  static const p07 = 0.7;
  static const p08 = 0.8;
  static const p09 = 0.9;
  static const p0 = 0.0;
  static const p1 = 1.0;
  static const p1_5 = 1.5;
  static const p2 = 2.0;
  static const p2_5 = 2.5;
  static const p3 = 3.0;
  static const p3_3 = 3.3;
  static const p3_5 = 3.5;
  static const p4 = 4.0;
  static const p4_3 = 4.3;
  static const p4_5 = 4.5;
  static const p5 = 5.0;
  static const p6 = 6.0;
  static const p7 = 7.0;
  static const p8 = 8.0;
  static const p9 = 9.0;
  static const p10 = 10.0;
  static const p11 = 11.0;
  static const p12 = 12.0;
  static const p14 = 14.0;
  static const p16 = 16.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p25 = 25.0;
  static const p30 = 30.0;
  static const p32 = 32.0;
  static const p35 = 35.0;
  static const p40 = 40.0;
  static const p48 = 48.0;
  static const p64 = 64.0;
  static const p80 = 80.0;
  static const p90 = 90.0;
  static const p100 = 100.0;
  static const p150 = 150.0;
  static const p180 = 180.0;
  static const p200 = 200.0;
}

class Box {
  /// [SizedBox] gap widths
  static SizedBox gapW1 = SizedBox(width: Sizes.p1.sw);
  static SizedBox gapW2 = SizedBox(width: Sizes.p2.sw);
  static SizedBox gapW4 = SizedBox(width: Sizes.p4.sw);
  static SizedBox gapW5 = SizedBox(width: Sizes.p5.sw);
  static SizedBox gapW6 = SizedBox(width: Sizes.p6.sw);
  static SizedBox gapW8 = SizedBox(width: Sizes.p8.sw);
  static SizedBox gapW12 = SizedBox(width: Sizes.p12.sw);
  static SizedBox gapW16 = SizedBox(width: Sizes.p16.sw);
  static SizedBox gapW20 = SizedBox(width: Sizes.p20.sw);
  static SizedBox gapW24 = SizedBox(width: Sizes.p24.sw);
  static SizedBox gapW32 = SizedBox(width: Sizes.p32.sw);
  static SizedBox gapW48 = SizedBox(width: Sizes.p48.sw);
  static SizedBox gapW64 = SizedBox(width: Sizes.p64.sw);

  /// [SizedBox] gap heights
  static SizedBox gapH1 = SizedBox(height: Sizes.p1.sh);
  static SizedBox gapH1_5 = SizedBox(height: Sizes.p1_5.sh);
  static SizedBox gapH2 = SizedBox(height: Sizes.p2.sh);
  static SizedBox gapH3 = SizedBox(height: Sizes.p3.sh);
  static SizedBox gapH4 = SizedBox(height: Sizes.p4.sh);
  static SizedBox gapH8 = SizedBox(height: Sizes.p8.sh);
  static SizedBox gapH12 = SizedBox(height: Sizes.p12.sh);
  static SizedBox gapH16 = SizedBox(height: Sizes.p16.sh);
  static SizedBox gapH20 = SizedBox(height: Sizes.p20.sh);
  static SizedBox gapH24 = SizedBox(height: Sizes.p24.sh);
  static SizedBox gapH32 = SizedBox(height: Sizes.p32.sh);
  static SizedBox gapH48 = SizedBox(height: Sizes.p48.sh);
  static SizedBox gapH64 = SizedBox(height: Sizes.p64.sh);
}

// Navigation Bar Height
const double navigationBarHeight = Sizes.p80;
