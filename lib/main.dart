import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_crud/pages/add_product.dart';
import 'package:flutter_app_crud/pages/add_student_page.dart';
import 'package:flutter_app_crud/pages/card_page.dart';
import 'package:flutter_app_crud/pages/cupon_page.dart';
import 'package:flutter_app_crud/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Firestone CRUD',
              theme: ThemeData(
                primarySwatch: Colors.red,
              ),
              debugShowCheckedModeBanner: false,
              home: AddProduct(),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
