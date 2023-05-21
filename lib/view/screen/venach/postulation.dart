import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/view/widget/boutton.dart';
import '../../widget/home/customtextfieldpost.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Postulation extends StatelessWidget {
  Postulation({Key? key}) : super(key: key);

  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _imagePicker.getImage(source: source);

    if (pickedImage != null) {
      _pickedImage = File(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Ajouter une annonce',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withAlpha(0),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          child: ListView(
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/post.png",
                    height: 190,
                  ),
                  SizedBox(height: 10),
                  CustomTextfieldAuth(
                    height: 20,
                    hinttext: "Ex: Plaquettes de frein",
                    labelText: "Titre",
                  ),
                  CustomTextfieldAuth(
                    height: 70,
                    hinttext: "Ex: haute qualité qui offre une performance fiable",
                    labelText: "Description",
                  ),
                  CustomTextfieldAuth(
                    height: 20,
                    hinttext: "Ex: 100dt",
                    labelText: "Prix",
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Choisir une source',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Comfortaa",
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Galerie',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Comfortaa",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.image, color: Colors.amber),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      _pickImage(ImageSource.gallery);
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Text("----------------------------------"),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Appareil photo',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Comfortaa",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.camera_alt, color: Colors.amber),
                                      ],
                                    ),
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      _pickImage(ImageSource.camera);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.circular(10)
        ),
        child: _pickedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  _pickedImage!,
                  fit: BoxFit.cover,
                ),
              )
            : Icon(
                Icons.add_a_photo,
                size: 40,
                color: Colors.grey,
              ),
      ),
    ),
                  
                  SizedBox(height: 20),
                  Boutton(text: "Postuler", color: Colors.amber),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



