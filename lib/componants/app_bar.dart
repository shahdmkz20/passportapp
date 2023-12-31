import 'package:ayat_project/componants/clip.dart';
import 'package:flutter/material.dart';

import '../../utlis/app_colors.dart';


class AppBarr extends StatelessWidget {
  final Function? onPressButton;
  final String textAppBar;
  final bool leading;
  final IconData? iconData;

  const AppBarr({
    required this.textAppBar,
    super.key,
    this.leading = false,
    this.onPressButton,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Clip3(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 9,
        child: AppBar(
          leading: leading
              ? IconButton(
                  onPressed: () => onPressButton!(),
                  icon:   Icon(iconData))
              : const SizedBox.shrink(),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              textAppBar,
              style: const TextStyle(fontSize: 28),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.defaultBlue,
        ),
      ),
    );
  }
}
