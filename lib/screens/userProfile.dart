import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:usercolorbackground/screens/home.dart';
import 'package:usercolorbackground/screens/login.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final userData = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: userData.get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                return Scaffold(
                  backgroundColor: Color(snapshot.data!["backgroundColor"]),
                  appBar: AppBar(
                    backgroundColor: Color(snapshot.data!["backgroundColor"]),
                    actions: [
                      IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Login();
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.logout),
                      )
                    ],
                  ),
                  body: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        color: Colors.white.withOpacity(0.5),
                        child: Row(
                          children: [Text("ID : "), Text(userData.id)],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        color: Colors.white.withOpacity(0.5),
                        child: Row(
                          children: [
                            Text("Username : "),
                            Text(snapshot.data!["username"])
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        color: Colors.white.withOpacity(0.5),
                        child: Row(
                          children: [
                            Text("Email : "),
                            Text(snapshot.data!["email"])
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        color: Colors.white.withOpacity(0.5),
                        child: Row(
                          children: [
                            Text("Type : "),
                            Text(snapshot.data!["type"])
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text("home"),
                ),
                body: const Center(
                  child: Text("Check your connection"),
                ),
              );
            }),
      ),
    );
  }
}
