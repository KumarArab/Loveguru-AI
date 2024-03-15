import 'package:flutter/material.dart';
import 'package:loveguru_ai/utils/fonts.dart';

class TStyle {
  static TextStyle gilroyThin = const TextStyle(fontFamily: Fonts.light);
  static TextStyle gilroyUltraLight = const TextStyle(fontFamily: Fonts.ultraLight);
static TextStyle gilroyLight = const TextStyle(fontFamily: Fonts.light);

  static TextStyle gilroyRegular = const TextStyle(fontFamily: Fonts.regular);
  static TextStyle gilroyMedium = const TextStyle(fontFamily: Fonts.medium);
static TextStyle gilroySemiBold = const TextStyle(fontFamily: Fonts.semiBold);

  static TextStyle gilroyBold = const TextStyle(fontFamily: Fonts.bold);
  static TextStyle gilroyExtraBold = const TextStyle(fontFamily: Fonts.extraBold);
  static TextStyle gilroyBlack = const TextStyle(fontFamily: Fonts.black);
}

extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w900);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle letterSpace(double value) => copyWith(letterSpacing: value);
  TextStyle weight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle colour(Color? color) => copyWith(color: color);
  TextStyle size(double size) => copyWith(fontSize: size);
  TextStyle setHeight(double height) => copyWith(height: height);
}

extension FontSize on TextStyle {
  /// Title 68 Size == 68
  ///
  TextStyle get title90 => copyWith(fontSize:90);
  TextStyle get title68 => copyWith(fontSize: 68);

  TextStyle get title50 => copyWith(fontSize: 50);

  /// Title 0 Size == 40
  TextStyle get title0 => copyWith(fontSize: 40);

  /// Title 1 Size == 34
  TextStyle get title1 => copyWith(fontSize: 34);

  /// Title 2 Size == 32
  TextStyle get title2 => copyWith(fontSize: 32);

  /// Title 3 Size == 26
  TextStyle get title3 => copyWith(fontSize: 26);

  /// Title 4 Size == 24
  TextStyle get title4 => copyWith(fontSize:24);


  /// Body 3 Size == 20
  TextStyle get body0 => copyWith(fontSize: 20);

  /// Body 3 Size == 18
  TextStyle get body1 => copyWith(fontSize: 18);

  /// Body 3 Size == 16
  TextStyle get body2 => copyWith(fontSize: 16);

  /// Body 3 Size == 14
  TextStyle get body3 => copyWith(fontSize: 14);

  /// Body 4 Size == 12
  TextStyle get body4 => copyWith(fontSize: 12);

  /// Body 4 Size == 8
  TextStyle get body5 => copyWith(fontSize: 8);
}
