import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usercolorbackground/components/homeview.dart';
import 'package:usercolorbackground/firebase_options.dart';
import 'package:usercolorbackground/screens/home.dart';
import 'package:usercolorbackground/screens/login.dart';
import 'package:usercolorbackground/screens/signUp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
//...
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return HomeViewModel();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    ),
  );
}
