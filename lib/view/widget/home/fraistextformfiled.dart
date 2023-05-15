import 'package:flutter/material.dart';

class FraisTextFormFiled extends StatelessWidget {
  const FraisTextFormFiled(TextEditingController textEditingController, {Key? key, required this.text, this.mycontroller}) : super(key: key);
 final String text ; 
 final TextEditingController? mycontroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: mycontroller,
          decoration: InputDecoration(
            label:Text(text) ,   
                hintText: "(JJ/MM/AAAA)",
                hintStyle: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 131, 127, 127) ,fontFamily: "Comfortaa",fontWeight: FontWeight.w800) ,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                const EdgeInsets.symmetric(vertical:20, horizontal: 20),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(14) ) ,),
        ),
    );
  }
}