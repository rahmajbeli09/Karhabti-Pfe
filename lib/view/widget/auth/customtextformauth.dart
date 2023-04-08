import 'package:flutter/material.dart';

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
              hintStyle: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 131, 127, 127) ,fontFamily: "Comfortaa",fontWeight: FontWeight.w800) ,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
              const EdgeInsets.symmetric(vertical:20, horizontal: 20),
              
              suffixIcon: Icon(iconData , color: Color.fromARGB(255, 131, 127, 127),),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14) ) ,),
        ),
      
    );
  }
}