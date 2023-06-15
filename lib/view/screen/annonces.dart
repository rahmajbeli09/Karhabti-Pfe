import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Annonces extends StatelessWidget {
  const Annonces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    // Retrieve the current user email
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;

    // Method to fetch the user ID based on email
    Future<String?> getUserID() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (snapshot.size > 0) {
        return snapshot.docs[0].id;
      }

      return null;
    }

    // Method to delete the article
    Future<void> deleteArticle(String documentId) async {
      await FirebaseFirestore.instance
          .collection('pièce_de_rechange')
          .doc(documentId)
          .delete();
    }

    // Method to show the confirmation dialog
 // Method to show the confirmation dialog
Future<void> showDeleteConfirmationDialog(BuildContext context, String documentId) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to delete this article?'),
        actions: <Widget>[
          TextButton(
            // ignore: deprecated_member_use
            style: TextButton.styleFrom(primary: Colors.yellow), // Set the color to yellow
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            // ignore: deprecated_member_use
            style: TextButton.styleFrom(primary: Colors.yellow), // Set the color to yellow
            child: Text('Yes'),
            onPressed: () {
              // Delete the article
              deleteArticle(documentId);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


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
          'Consulter vos annonces',
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
          Image.asset("assets/images/annonce.png"),
          Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 148, 138, 138),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<String?>(
              future: getUserID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError || snapshot.data == null) {
                  return Text('Error fetching user ID');
                }

                final String userId = snapshot.data!;

                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('pièce_de_rechange')
                      .where('userId', isEqualTo: userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    final documents = snapshot.data!.docs;

                    // Apply search filter if input text is not empty
                    final filteredDocuments = searchController.text.isNotEmpty
                        ? documents
                            .where((doc) => doc['titre']
                                .toString()
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
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
                        final documentId = filteredDocuments[index].id;

                        // Customize the display of the document data here
                        return GestureDetector(
                          // Inside the GridView builder's onTap callback
                          onTap: () {
                            // Add the navigation logic here
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
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
                                    IconButton(
                                              icon: Icon(
                                              Icons.delete,
                                              color: Colors.yellow, // Set the color to yellow
                                            ),
                                      onPressed: () {
                                        // Show the confirmation dialog
                                        showDeleteConfirmationDialog(context, documentId);
                                      },
                                    ),
                                  ],
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
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
