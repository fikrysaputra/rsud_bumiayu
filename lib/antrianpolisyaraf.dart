// ignore_for_file: avoid_print, unused_import

import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rsudbumiayu/antrianpasien.dart';
import 'auth.dart';
import 'dashboard.dart';

class Polisyaraf extends StatefulWidget {
  const Polisyaraf({Key? key}) : super(key: key);

  @override
  State<Polisyaraf> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Polisyaraf> {
  final Stream<QuerySnapshot> _queuesStream =
      FirebaseFirestore.instance.collection('antriansyaraf').snapshots();

  int _queue=0;
  final int _totalQueue = 10;

  CollectionReference antrian =
      FirebaseFirestore.instance.collection('antriansyaraf');

  Future<void> addQueueSyaraf() {

    bool isFinal = (_totalQueue <= _queue);
    setState(() {
      if (!isFinal) _queue++;
    });

    if (!isFinal) {
      return antrian
          .doc(email)
          .set(
            {
              'urutan': _queue,
              'namapasien': name,
              'poliklinik': "Syaraf",
            },
            SetOptions(merge: true),
          )
          .then((value) => print("Queue Added"))
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
              title: const Text("Antrian Poliklinik Syaraf"),
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
                    subtitle: Text("Nama Akun : ${data['namapasien']}",
                        style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
              ),
            ),
            floatingActionButton: ElevatedButton(
              onPressed: addQueueSyaraf,
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
