import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:karhabti_pfe/controller/onboarding_controller.dart';

import '../../../data/datasource/static/static.dart';

class CustomDotController extends StatelessWidget {
  const CustomDotController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: ((controller) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                    onBoardingList.length,
                     (index) => AnimatedContainer(
                      margin: const EdgeInsets.all(8),
                    duration: const Duration(microseconds:900 ),
                    width: controller.currentPage == index ? 15 : 6,
                    height: 6,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 136, 131, 131),
                    ),

                    ))
                    ],
                  ))
      );
  }
}