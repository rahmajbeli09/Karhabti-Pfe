import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karhabti_pfe/controller/client/editprofilcntroller.dart';
import 'package:karhabti_pfe/controller/technicien/profiltechcontroller.dart';
import 'package:karhabti_pfe/services/user_model.dart';
import '../../../../../../services/tech_model.dart';
import '../../../../../widget/boutton.dart';

class EditTechProfil extends StatelessWidget {
  final controllerr = Get.put(EditController());

  EditTechProfil({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
 
    final controlleer = Get.put(ProfilTechControllerImp());

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
          'Modifier vos données personnelles',
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: controlleer.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                   TechModel user = snapshot.data as TechModel;
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(user.imageURL ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    );
                  }
                }
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              height: 400, // Adjust the height as desired
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: FutureBuilder(
                future: controlleer.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      TechModel user = snapshot.data as TechModel;
                      final fullname =
                          TextEditingController(text: user.fullname);
                      final phoneNumber =
                          TextEditingController(text: user.phoneNumber);
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: fullname,
                                    decoration: InputDecoration(
                                      labelText: 'Full Name',
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: phoneNumber,
                                    decoration: InputDecoration(
                                      labelText: 'Phone number',
                                      prefixIcon: Icon(Icons.phone),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          if (formKey.currentState!.validate()) {
                                            TechModel updatedUser = TechModel(
                                              id: user.id,
                                              email: user.email,
                                              fullname: fullname.text,
                                              phoneNumber: phoneNumber.text,
                                              password: user.password,
                                            );
                                            await controlleer.updateRecord(
                                                user.id!, updatedUser );
                                            print(
                                                'User data updated: $updatedUser');
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                                          padding: MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                          ),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                          ),
                                        ),
                                        icon: Icon(Icons.save),
                                        label: Text(
                                          'Enregistrer',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

