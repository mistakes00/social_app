import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIcons {
  add,
  chat,
  home,
  person,
  prev,
  search,
  cancel,
}

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double size;
  final Color? color;
  final bool originalColor;

  const AppIcon(
    this.icon, {
    Key? key,
    this.size = 20,
    this.color,
    this.originalColor = false, // const Color(0xff636363),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Center(
        child: SvgPicture.asset(
          'assets/svg/${icon.name}.svg',
          color: originalColor ? null : color ?? IconTheme.of(context).color,
          height: size,
          width: size,
        ),
      ),
    );
  }
}
