import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/onboarding_controller.dart';
import '../../../data/datasource/static/static.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (val){
        controller.onPageChanged(val);
      },
                  itemCount: onBoardingList.length,
                  itemBuilder: (context ,i) => Column
                  (children: [
                     Container(
                      decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(8)),
                       width: 330, 
                       height: 400, 
                       child: Image.asset(onBoardingList[i].image! ,
                        fit: BoxFit.fill,)
                     ),
                      const SizedBox(height: 25,),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text
                        (onBoardingList[i].title!,
                         textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 23 , fontWeight: FontWeight.w600 ,fontFamily: "Comfortaa",),
                             
                        ),
                    ),
                    const SizedBox(height:10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text
                        (onBoardingList[i].body! , textAlign: TextAlign.center, 
                        style: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500 , fontFamily: "Comfortaa",)
                         ),
                      )
                ])
                    ,);
  }
}