// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:usercolorbackground/screens/home.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
Color pickerColor = Colors.blue;
int colorCode = Colors.blue.hashCode;
// ignore: non_constant_identifier_names
GlobalKey<FormState> MyFormKey = GlobalKey();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: MyFormKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Color.fromARGB(255, 5, 85, 97),
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.toString().contains("@") == false) {
                        return "Email must contain @ symbol!";
                      }
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.toString().length <= 6) {
                        return "The passord must be at least 7 letters";
                      }
                    },
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pickerColor,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: (Color color) {
                                    setState(() {
                                      colorCode = color.hashCode;
                                      pickerColor = Color(colorCode);
                                    });
                                  },
                                  displayThumbColor: true,
                                  hexInputBar: true,
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Got it'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text('Pick a color'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 5, 85, 97),
                    ),
                    child: const Text('Sign up'),
                    onPressed: () async {
                      if (MyFormKey.currentState!.validate()) {
                        try {
                          FirebaseAuth AuthObjct = FirebaseAuth.instance;
                          UserCredential SignUpuser =
                              await AuthObjct.createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(SignUpuser.user!.uid)
                              .set(
                            {
                              "email": emailController.text,
                              "username": nameController.text,
                              "backgroundColor": colorCode,
                              "type": "normal user"
                            },
                          );
                          emailController.clear();
                          nameController.clear();
                          passwordController.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              },
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Login();
                              },
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Successfully registered"),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.message.toString(),
                              ),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sorry something wrong"),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                Row(
                  // ignore: sort_child_properties_last
                  children: <Widget>[
                    const Text('Already have account'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 5, 85, 97),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
