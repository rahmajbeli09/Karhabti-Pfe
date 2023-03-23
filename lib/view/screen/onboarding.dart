import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/onboarding_controller.dart';
import 'package:karhabti_pfe/view/widget/onboarding/custombutton.dart';
import 'package:karhabti_pfe/view/widget/onboarding/customslider.dart';
import 'package:karhabti_pfe/view/widget/onboarding/dotcontroller.dart';
import '../widget/mode.dart';
import '../widget/onboarding/skipbutton.dart';



class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return Scaffold(
       appBar : AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
          actions: [
          SizedBox(width: 40,),
          Mode(),
        ]),
      body: 
        SafeArea(
          child: Column(
            children: [
              const Expanded(
                flex: 4,
                child: CustomSliderOnBoarding()
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children:const [
                   SkipButton(),
                   SizedBox(width: 28,),
                  CustomDotController(),
                  SizedBox(width: 28,),
                  CustomButtonOnBoarding(),
             ] 
             ))
            ],
          ),
          

        )
    );
  }
}