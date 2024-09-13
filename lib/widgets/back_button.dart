import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/routes/routes.dart';
import 'package:weather_app/styles/colors.dart';

class IconsPaths {
  String get backArrowIcon => 'assets/icons/back_arrow.svg';
}

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteManager.searchPage,
          (route) => false,
        );
      },
      padding: EdgeInsets.zero,
      child: Container(
        width: 41,
        height: 41,
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors().border),
        ),
        child: Center(
          child: SvgPicture.asset(IconsPaths().backArrowIcon),
        ),
      ),
    );
  }
}
