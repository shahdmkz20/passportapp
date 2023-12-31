import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerShadowAll extends StatelessWidget {
  final Widget widget;
  const ContainerShadowAll(
      {super.key,
        required this.widget,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  double.infinity ,
      height: 350,
      decoration: BoxDecoration(
        color: AppColors.defaultWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow:
             [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 10.0,
            spreadRadius: 4.0,
            offset: const Offset(0.0, 4.0),
          ),
        ]
      ),
      child: widget,
    );
  }
}
