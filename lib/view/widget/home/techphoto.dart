
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../repository/user_repository/tech_repository.dart';
import '../../../services/tech_model.dart';

class TechnicianContainer extends StatefulWidget {
  const TechnicianContainer({Key? key}) : super(key: key);

  @override
  _TechnicianContainerState createState() => _TechnicianContainerState();
}

class _TechnicianContainerState extends State<TechnicianContainer> {
  File? _imageFile;
  String? _imageURL;
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$imageFileName.jpg');
      UploadTask uploadTask = storageReference.putFile(File(pickedFile.path));
      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        String imageURL = await snapshot.ref.getDownloadURL();

        final TechRepository techRepository = Get.put(TechRepository());
        final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

        final User? currentUser = _firebaseAuth.currentUser;
        if (currentUser == null) {
          print('User not found!!!');
          return;
        }
        final String userEmail = currentUser.email!;

        final TechModel? user = await techRepository.getUserDetaiil(userEmail);
        if (user == null) {
          print('Technician not found!');
          return;
        }

        final String? userId = user.id;

        final CollectionReference techniciansCollection =
            FirebaseFirestore.instance.collection('Techniciens');
        final DocumentReference technicianDocument = techniciansCollection.doc(userId);
        technicianDocument.update({'imageURL': imageURL}).then((_) {
          setState(() {
            _imageURL = imageURL;
          });

          Get.snackbar(
            "Success!",
            "Your image has been uploaded.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
        }).catchError((error) {
          Get.snackbar(
            "Error!",
            "Failed to upload image: $error",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red,
          );
        });
      }
    } else {
      print('No image selected.');
    }
  }

  Future<void> _loadProfilePicture() async {
    final TechRepository techRepository = Get.find<TechRepository>();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final User? currentUser = _firebaseAuth.currentUser;

    if (currentUser != null) {
      final String? userEmail = currentUser.email;
      final TechModel? user = await techRepository.getUserDetailss(userEmail!);
      if (user != null && user.imageURL != null) {
        setState(() {
          _imageURL = user.imageURL;
        });
      } else {
        setState(() {
          _imageURL = null; // Reset _imageURL if user doesn't have a profile picture
        });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    final TechRepository techRepository = Get.find<TechRepository>();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final User? currentUser = _firebaseAuth.currentUser;
    TechModel? user;

       return Container(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: Get.width / 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 255, 203, 30),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
            ),
          ),
          Positioned(
            top: Get.width / 10.5,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Choose an option'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Upload from Gallery'),
                            onTap: () {
                              _selectImage();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (_imageURL != null
                          ? NetworkImage(_imageURL!) as ImageProvider<Object>
                          : AssetImage("assets/images/profil.png")),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}