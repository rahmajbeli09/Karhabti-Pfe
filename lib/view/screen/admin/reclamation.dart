import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reclamation extends StatelessWidget {
  const Reclamation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Reclamations"),
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reclamations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final titre = document['titre'] as String;
                final description = document['description'] as String;
                final userEmail = document['email'] as String;
                final userId = document['userId'] as String;

                return Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Titre:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(titre),
                            SizedBox(height: 4.0),
                            Text(
                              'Description:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(description),
                            Text(
                              'Email of the sender:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(userEmail),
                            Text(
                              'User ID:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(userId),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Delete Reclamation'),
                              content: Text('Are you sure you want to delete this reclamation?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Delete reclamation document from Firestore
                                    document.reference.delete();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
