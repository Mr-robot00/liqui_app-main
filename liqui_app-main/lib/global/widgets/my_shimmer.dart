import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/index.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer {
  Widget _shimmerEffect(Widget child) {
    return Shimmer.fromColors(
      baseColor: Get.isDarkMode
          ? myHelper.darken(color: shimmerBaseColor)
          : shimmerBaseColor,
      highlightColor: Get.isDarkMode
          ? myHelper.darken(color: shimmerHighlightColor)
          : shimmerHighlightColor,
      child: child,
    );
  }

  Widget get dashboardShimmer {
    return _shimmerEffect(
      Padding(
        padding: const EdgeInsets.all(padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedContainer(height: 60, radius: 8, width: 200),
                  RoundedContainer(height: 60, radius: 8, width: 150),
                ]),
            const SizedBox(height: 20),
            RoundedContainer(height: 120, radius: 8, width: screenWidth - 36),
            const SizedBox(height: 20),
            RoundedContainer(height: 180, radius: 8, width: screenWidth - 36),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              RoundedContainer(
                  height: 120, radius: 8, width: (screenWidth - 64) / 3),
              RoundedContainer(
                  height: 120, radius: 8, width: (screenWidth - 64) / 3),
              RoundedContainer(
                  height: 120, radius: 8, width: (screenWidth - 64) / 3),
            ]),
            const SizedBox(height: 20),
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedContainer(height: 30, radius: 8, width: 150),
                  RoundedContainer(height: 30, radius: 8, width: 150),
                ]),
            const SizedBox(height: 20),
            RoundedContainer(height: 100, radius: 8, width: screenWidth - 36),
            const SizedBox(height: 20),
            const RoundedContainer(height: 30, width: 180),
            const RoundedContainer(height: 30, width: 250),
            const SizedBox(height: 20),
            RoundedContainer(height: 180, radius: 8, width: screenWidth - 36),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget get transactionsShimmer {
    return _shimmerEffect(
      SingleChildScrollView(
        padding: const EdgeInsets.all(padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RoundedContainer(height: 250, radius: 8, width: screenWidth - 36),
            // const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, pos) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RoundedContainer(height: 30, width: 250),
                        SizedBox(height: padding5),
                        RoundedContainer(height: 20, width: 180)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RoundedContainer(height: 30, width: 100),
                        SizedBox(height: padding5),
                        RoundedContainer(height: 20, width: 150)
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, pos) {
                return const SizedBox(height: padding10);
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget get portfolioTransactionShimmer {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(padding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedContainer(height: 150, width: screenWidth - 36,radius: 8,),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, pos) {
                  return const RoundedContainer(height: 75, width: 180,radius: 8);
                },
                separatorBuilder: (context, pos) {
                  return const SizedBox(height: padding10);
                },
                itemCount: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get profileShimmer {
    return _shimmerEffect(
      SingleChildScrollView(
        padding: const EdgeInsets.all(padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: RoundedContainer(height: 70, radius: 8)),
                  SizedBox(width: padding16),
                  RoundedContainer(height: 70, radius: 35, width: 70),
                ]),
            const SizedBox(height: 20),
            RoundedContainer(height: 150, radius: 8, width: screenWidth - 32),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, pos) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedContainer(height: 40, width: 40),
                    SizedBox(width: padding16),
                    Expanded(child: RoundedContainer(height: 40)),
                    SizedBox(width: padding16),
                    RoundedContainer(height: 40, width: 40),
                  ],
                );
              },
              separatorBuilder: (context, pos) {
                return const SizedBox(height: padding10);
              },
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}

final myShimmer = MyShimmer();
