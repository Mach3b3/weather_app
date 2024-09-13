import 'package:flutter/material.dart';
import 'package:weather_app/styles/app_style.dart';

class LargeText extends StatelessWidget {
  final String largeTitle;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  const LargeText({
    super.key,
    required this.largeTitle,
    this.fontFamily,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      largeTitle,
      style: TextStyling.titleLarge(context)!.copyWith(
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}

class MediumText extends StatelessWidget {
  final String middleTitle;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  const MediumText({
    super.key,
    required this.middleTitle,
    this.fontFamily,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      middleTitle,
      style: TextStyling.titleMedium(context)!.copyWith(
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String smallText;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  const SmallText({
    super.key,
    required this.smallText,
    this.fontFamily,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      smallText,
      style: TextStyling.titleSmall(context)!.copyWith(
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
