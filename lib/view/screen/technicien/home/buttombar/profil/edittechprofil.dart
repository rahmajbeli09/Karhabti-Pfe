import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../controller/technicien/profiltechcontroller.dart';
import '../../../../../../services/tech_model.dart';
import '../../../../../widget/boutton.dart';

class EditTechProfil extends StatelessWidget {
final controllerr = Get.put(ProfilTechControllerImp());

   EditTechProfil({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controllerr = Get.put(ProfilTechControllerImp());

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
          'Trouver un expert',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.white.withAlpha(0),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/profil.png',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 40),
            Expanded(
            child :Container(
              
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
  future: controllerr.getUserData(),
  builder: (context, snapshot) {
    print('futureBuilder snapshot: $snapshot');

    if (snapshot.connectionState == ConnectionState.done) {
      print("connected"); //means that the data is fetched
      if (snapshot.hasData) {
        print(snapshot.data);
        print("snapshot worked");
        TechModel user = snapshot.data as TechModel;
        final email = TextEditingController(text: user.email);
        final password = TextEditingController(text: user.password);
        final phoneNumber = TextEditingController(text: user. phoneNumber);
        final fullname = TextEditingController(text: user.fullname);
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullname,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                      ),

                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: phoneNumber,
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,

                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,

                    ),
                    
                    const SizedBox(height: 20,),
ElevatedButton(
   onPressed: () async {
    if (formKey.currentState!.validate()) {
      TechModel updatedUser = TechModel(
        id: user.id,
        email: email.text,
        fullname: fullname.text,
        phoneNumber: phoneNumber.text,
        password: password.text,
      );
      await controllerr.updateRecord(user.id!, updatedUser);
      print('User data updated: $updatedUser');
    }
  },
  child: Text('Save Changes'),
)


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
    // Handle other connection states here
    return const Center(child: CircularProgressIndicator());
  },
),



            ),
              ),
          ],
        ),
      ),
    );
  }
}
