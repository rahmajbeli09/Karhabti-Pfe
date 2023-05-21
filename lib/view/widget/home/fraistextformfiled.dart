import 'package:flutter/material.dart';
class FraisTextFormFiled extends StatelessWidget {
  const FraisTextFormFiled({
    Key? key,
    required this.text,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          controller: controller,
          enabled: false, // Disable editing directly in the field
          decoration: InputDecoration(
            labelText: text,
            hintText: "(JJ/MM/AAAA)",
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 131, 127, 127),
              fontFamily: "Comfortaa",
              fontWeight: FontWeight.w800,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}


