import 'package:flutter/material.dart';
import 'package:karhabti_pfe/core/constant/color.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  final IconData iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  const CustomTextFormAuth(
      {Key? key,
      required this.hinttext,
      required this.iconData,
      required this.mycontroller, required this.valid,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin:const  EdgeInsets.only(bottom: 15),
        child: TextFormField(
          validator: valid,
          controller: mycontroller,
          decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: const TextStyle(fontSize: 15, color: ColorApp.grey ,fontFamily: "Comfortaa",) ,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
              const EdgeInsets.symmetric(vertical:20, horizontal: 20),
              
              suffixIcon: Icon(iconData , color: ColorApp.grey,),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14) ) ,),
        ),
      
    );
  }
}