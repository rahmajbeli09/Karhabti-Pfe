import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchUser(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Users"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchUser,
              decoration: InputDecoration(
                hintText: 'Search by name or email',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> userDocuments = snapshot.data!.docs;
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Techniciens').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> technicienDocuments = snapshot.data!.docs;
                        final List<DocumentSnapshot> allDocuments = [...userDocuments, ...technicienDocuments];

                        final filteredDocuments = _searchQuery.isEmpty
                            ? allDocuments
                            : allDocuments
                                .where((doc) => doc['email'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
                                    doc['fullname'].toString().toLowerCase().contains(_searchQuery.toLowerCase()))
                                .toList();
                        return ListView.builder(
                          itemCount: filteredDocuments.length,
                          itemBuilder: (context, index) {
                            final document = filteredDocuments[index];
                            final email = document['email'] as String;
                            final fullname = document['fullname'] as String;
                            final phoneNumber = document['phoneNumber'] as String;
                            final role = technicienDocuments.contains(document) ? document['role'] as String : null;

                            return Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text('Email: $email'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Full Name: $fullname'),
                                    Text('Phone Number: $phoneNumber'),
                                    if (role != null) Text('Role: $role'),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Delete User'),
                                        content: Text('Are you sure you want to delete this user?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Delete user document from Firestore
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
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching data'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
