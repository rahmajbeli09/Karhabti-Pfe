import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final Rx<File?> imageFile = Rx<File?>(null);

  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      imageFile.value = File(result.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectImage,
      child: Obx(
        () => Container(
          width: 200,
          height: 200,
          child: DottedBorder(
            color: Color.fromARGB(255, 255, 203, 30),
            strokeWidth: 3,
            dashPattern: [6, 3],
            borderType: BorderType.RRect,
            radius: Radius.circular(20),
            child: imageFile.value == null
              ? Container(
                margin: EdgeInsets.symmetric(vertical: 60 , horizontal: 25),
                  child: Column(
                    children: [
                     Icon(Icons.add , size: 50,color: Color.fromARGB(255, 255, 203, 30),),
                     SizedBox(height: 5,),
                     Text('Ajouter une image',style:const TextStyle(fontWeight: FontWeight.bold , fontSize: 15 , fontFamily: "Comfortaa",)),

                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    imageFile.value!,
                    fit: BoxFit.cover,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
