import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _fomKey = GlobalKey<FormState>();
  final estilo = TextStyle(fontSize: 30);
  var cnt = 0;

  var name = "";
  var descrition = "";
  var value = "";

  final nameController = TextEditingController();
  final descritionController = TextEditingController();
  final valueController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descritionController.dispose();
    valueController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    descritionController.clear();
    valueController.clear();
  }

  void decrement() {
    setState(() {
      cnt--;
    });
  }

  void increment() {
    setState(() {
      cnt++;
    });
  }

  void zerar() {
    setState(() {
      cnt == Null;
    });
  }

  bool get isEmpty => cnt == 0;
  bool get isFull => cnt == 99;

  // Adding Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> addUser() {
    return students
        .add({'nome': name, 'descrition': descrition, 'value': value})
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Product",
        ),
        backgroundColor: Colors.grey,
      ),
      body: Form(
        key: _fomKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Name: ',
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Name';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                cursorHeight: 20,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Descrição: ',
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                controller: descritionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter descrition';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Value: ',
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                controller: valueController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Value';
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.9, 0.47),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Quantidade Por Porção',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.minimize, size: 18),
                            color: const Color(0xFFFF0000),
                            onPressed: isEmpty ? null : decrement,
                          ),
                          Text(
                            '$cnt',
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            color: const Color(0xFFFF0000),
                            onPressed: isFull ? null : increment,
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Adicionar Imagem:"),
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text(
                      'Selecionar imagem',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0),
              width: 3,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_fomKey.currentState!.validate()) {
                    setState(() {
                      name = nameController.text;
                      descrition = descritionController.text;
                      value = valueController.text;
                      addUser();
                      clearText();
                    });
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                child: Text(
                  "Adicionar Produto",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
