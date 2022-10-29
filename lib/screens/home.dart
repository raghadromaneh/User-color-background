import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usercolorbackground/components/homeview.dart';
import 'package:usercolorbackground/screens/login.dart';
import 'package:usercolorbackground/screens/userProfile.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// String? userType;

class _HomeState extends State<Home> {
  final userData = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    return FutureBuilder(
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
            body: Center(
              child: Consumer<HomeViewModel>(
                builder: (context, HomeViewModel provider, _) {
                  return Column(
                    children: [
                      RadioListTile(
                        value: "Admin",
                        title: Text("Admin"),
                        groupValue: provider.userType,
                        onChanged: (String? value) {
                          provider.setUserType(value);
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "type": value,
                          });
                        },
                      ),
                      RadioListTile(
                        value: "Normal user",
                        title: Text("Normail user"),
                        groupValue: provider.userType,
                        onChanged: (String? value) {
                          provider.setUserType(value);
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "type": value,
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UserProfile();
                              },
                            ),
                          );
                        },
                        child: Text("User profile"),
                      )
                    ],
                  );
                },
              ),
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
      },
    );
  }
}
