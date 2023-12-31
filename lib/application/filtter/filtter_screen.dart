import 'package:ayat_project/application/filtter/fillter_controller.dart';
import 'package:ayat_project/application/filtter/fillter_widget.dart';
import 'package:ayat_project/application/payment/payment.dart';
import 'package:ayat_project/componants/app_bar.dart';
import 'package:ayat_project/componants/btn.dart';
import 'package:ayat_project/componants/details_widget.dart';
import 'package:ayat_project/utlis/app_colors.dart';
import 'package:ayat_project/utlis/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class FilterScreen extends StatelessWidget {
  final FilterController filterController = Get.put(FilterController());

  FilterScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.defaultWhite,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.defaultBlue,
          onPressed: () async {
            await filterController.getInf();
            if (filterController.getPassportState.value ==
                GetInformationState.failure) {
              // ignore: use_build_context_synchronously
              AppConstants.showToast(
                  context, "الرجاء التاكد من الاتصال بالانترنت");
            }
          },
          child: const Icon(Icons.update),
        ),
        // appBar: const AppBarr(textAppBar: 'Filter Screen'),
        body: Stack(
          children: [
            Obx(() {
              if (filterController.getPassportState.value ==
                  GetInformationState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 80, horizontal: 30),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: const ContainerShadowAll(
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TitleContent(
                              title: '',
                              content: '',
                            ),
                            TitleContent(
                              title: '',
                              content: '',
                            ),
                            TitleContent(
                              title: '',
                              content: '',
                            ),
                            TitleContent(
                              title: '',
                              content: '',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (filterController.getPassportState.value ==
                  GetInformationState.success) {
                return ListView(
                  children: [
                    const SizedBox(height: 87),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 30),
                      child: filterController
                              .getPassportModel.value.data!.isNotEmpty
                          ? Stack(
                              children: [
                                ContainerShadowAll(
                                  widget: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TitleContent(
                                        title: 'Date Passport',
                                        content:
                                            DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(
                                            filterController.getPassportModel
                                                .value.data![0].requestDate
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      TitleContent(
                                        title: 'Request Id',
                                        content: filterController
                                            .getPassportModel.value.data![0].id
                                            .toString(),
                                      ),
                                      TitleContent(
                                        title: 'State Order',
                                        content: filterController
                                                    .getPassportModel
                                                    .value
                                                    .data![0]
                                                    .requestState ==
                                                1
                                            ? 'Un Paid'
                                            : filterController
                                                        .getPassportModel
                                                        .value
                                                        .data![0]
                                                        .requestState ==
                                                    2
                                                ? 'Binding'
                                                : filterController
                                                            .getPassportModel
                                                            .value
                                                            .data![0]
                                                            .requestState ==
                                                        4
                                                    ? 'Cancled'
                                                    : 'Done',
                                      ),
                                      TitleContent(
                                        title: 'Note',
                                        content: filterController
                                            .getPassportModel
                                            .value
                                            .data![0]
                                            .notes,
                                      ),
                                    ],
                                  ),
                                ),
                                filterController.getPassportModel.value.data![0]
                                            .requestState ==
                                        1
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 330, left: 40, right: 40),
                                        child: defaultButton(
                                          text: 'payment',
                                          function: () {
                                            Get.to(InformationPayment());
                                          },
                                          bkColor: AppColors.defaultBlue,
                                          txtColor: Colors.white,
                                          blurClr: Colors.blueGrey,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            )
                          : Column(
                              children: [
                                Center(
                                  child: Lottie.asset(
                                    'assets/json/splash.json',
                                    animate: true,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 50, horizontal: 20),
                                  child: Text('You Do Not Add Any Request',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22)),
                                ),
                              ],
                            ),
                    ),
                  ],
                );
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 90, horizontal: 40),
                  child: Text(
                    filterController.errorMessage.value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                );
              }
            }),
            const AppBarr(textAppBar: 'Request Screen'),
          ],
        ),
      ),
    );
  }
}
