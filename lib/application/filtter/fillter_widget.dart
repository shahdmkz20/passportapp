import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/componants/details_widget.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:flutter/material.dart';

class ItemContain extends StatelessWidget {
  final int typeFilter;
  // final Function? onButtonPress;
  const ItemContain({Key? key,required this.typeFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView(
      children:  [
        Stack(
          children: [
          const  ContainerShadowAll(
              widget: Column(
                children: [
                  TitleContent(title: 'Date Passport',content: '24/8/2023'),
                  TitleContent(title: 'Order Number',content: '152542'),
                  TitleContent(title: 'State Order',content: 'Pending'),
                  TitleContent(title: 'Note',content: 'Unpaid'),
                ],
              ),
            ),
          typeFilter==0?
            defaultButton(
              text: 'Log In',
              function: () {
                // onButtonPress!();
              },
              bkColor:AppColors.defaultBlue,
              txtColor: Colors.white,
              blurClr: Colors.blueGrey,
            ):const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}


class TitleContent extends StatelessWidget {
  final String title;
  final String content;

  const TitleContent({super.key, required this.content, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 20,
              color: Colors.black,
              // fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
}