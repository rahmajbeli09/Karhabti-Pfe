import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karhabti_pfe/view/screen/venach/piece.dart';
import 'package:karhabti_pfe/view/screen/venach/search_product.dart';

import '../../../controller/client/ventachcontroller.dart';

// ignore: must_be_immutable
class VenteAchat extends StatelessWidget {
  VenteAchat({Key? key}) : super(key: key);
  VentAchCotrollerImp controller = Get.put(VentAchCotrollerImp());
  TextEditingController searchController = TextEditingController();

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
          'Recherche de pièces',
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: GestureDetector(
              onTap: () {
                // Navigate to search overlay or search results screen
               Get.to(Searchproduct());

              },
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Rechercher",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 131, 127, 127),
                    fontFamily: "Comfortaa",
                    fontWeight: FontWeight.w800,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 131, 127, 127),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('pièce_de_rechange').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;

                  // Apply search filter if input text is not empty
                  final filteredDocuments = searchController.text.isNotEmpty
                      ? documents
                          .where((doc) =>
                              doc['titre'].toString().toLowerCase().contains(searchController.text.toLowerCase()))
                          .toList()
                      : documents.toList();

                  // Render the grid of documents
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Display 2 items per row
                      childAspectRatio: 0.7, // Adjust the aspect ratio as needed
                    ),
                    itemCount: filteredDocuments.length,
                    itemBuilder: (context, index) {
                      final documentData = filteredDocuments[index].data();

                      // Customize the display of the document data here
                      return GestureDetector(
                 // Inside the GridView builder's onTap callback
                            onTap: () {
                              Get.to(Piece(), arguments: {'documentData': documentData});
                            },

                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 1, // Adjust the aspect ratio as needed
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    documentData['imageURL'],
                                    fit: BoxFit.cover, // Adjust the image fit as needed
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                documentData['titre'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                documentData['prix'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 280, top: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 203, 30),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                controller.goToPostulation();
              },
              icon: Icon(Icons.add),
              color: Colors.white, // Set the button color here
            ),
          ),
        ],
      ),
    );
  }
}
