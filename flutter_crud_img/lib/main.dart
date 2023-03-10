import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_img/pag/error_page.dart';
import 'package:flutter_crud_img/pag/loading_page.dart';
import 'package:flutter_crud_img/pag/storage_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _inicializacao = Firebase.initializeApp();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Storage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        brightness: Brightness.dark,
      ),
      home: FutureBuilder(
        future: _inicializacao,
        builder: (context, app) {
          if (app.connectionState == ConnectionState.done) {
            return const StoragePage();
          }

          if (app.hasError) return const ErrorPage();

          return const LoadingPage();
        },
      ),
    );
  }
}
