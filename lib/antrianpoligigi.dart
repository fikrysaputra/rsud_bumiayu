// ignore_for_file: avoid_print, unused_import

import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rsudbumiayu/antrianpasien.dart';
import 'package:rsudbumiayu/dashboard.dart';
import 'auth.dart';

class Poligigi extends StatefulWidget {
  const Poligigi({Key? key}) : super(key: key);

  @override
  State<Poligigi> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Poligigi> {
  final Stream<QuerySnapshot> _queuesStream =
      FirebaseFirestore.instance.collection('antriangigi').snapshots();

  CollectionReference antrian =
      FirebaseFirestore.instance.collection('antriangigi');

  int queue = 0;
  final int totalQueue = 10;

  Future<void> addQueueGigi() {
    bool isFinal = (totalQueue <= queue);
    setState(() {
      if (!isFinal) queue++;
    });

    if (!isFinal) {
      return antrian
          .doc(email)
          .set(
            {
              'urutan': queue,
              'akun': name,
              'poliklinik': "Gigi",
            },
        SetOptions(merge: true),
          )
          .then((value) => print('Queue Added'))
          .catchError((error) => print("Failed to add queue: $error"));
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _queuesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: ListTile(
                leading: CircularProgressIndicator(),
                title: Text('Loading...'),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Antrian Poliklinik Gigi"),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const Wantrian();
                    },
                  ));
                },
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2DA6AB),
                    Color(0xFF247EAA),
                  ],
                ),
              ),
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text("Nomer Antrian : ${data['urutan']}",
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text("Nama Akun : ${data['akun']}", style: const TextStyle(color: Colors.white),),
                  );
                }).toList(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: addQueueGigi,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
