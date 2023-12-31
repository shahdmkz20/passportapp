import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetWidget extends StatelessWidget {
  final Function onRepeatLoad;
  const NoInternetWidget({
    super.key,
    required this.onRepeatLoad,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      child: Column(
        children: [
          Lottie.asset(
            'assets/json/nointernet.json',
            animate: true,
            height: 400,
            width: 200,
            fit: BoxFit.scaleDown,
          ),
          defaultButton(
              text:  'Reload',
              function: () => onRepeatLoad(),
              bkColor: AppColors.defaultBlue,
              txtColor: AppColors.defaultWhite),
          // BtnAll(onButtonpress: () => onRepeatLoad(), textBtn: 'اعادة التحميل')
        ],
      ),
    );
  }
}
