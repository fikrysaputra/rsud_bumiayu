import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsudbumiayu/welcome.dart';
import 'auth.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  IniBeranda createState() => IniBeranda();
}

class IniBeranda extends State<Beranda> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('DataPasien');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF247EAA),
                  Color(0xFF2DA6AB),
                ],
              ),
            ),
            child:
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
                  child: ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  imageUrl,
                                ),
                                radius: 30,
                                backgroundColor: Colors.transparent,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Selamat Datang !"),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  keluarDialog();
                                },
                                alignment: Alignment.centerRight,
                                icon: const Icon(
                                    Icons.power_settings_new_outlined,
                                    color: Colors.red,
                                    size: 30.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 480.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FutureBuilder<DocumentSnapshot>(
                        future: users.doc(email).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Error");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return const Text("Data Pasien Belum diisi");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Data anda sudah diisi!"),
                              Text("Nama : ${data['Nama_Pasien']}"),
                              Text("Umur : ${data['Umur']}"),
                              Text("Tangga Lahir : ${data['Tanggal_Lahir']}"),
                              Text("Alamat : ${data['Alamat']}"),
                              Text("BPJS : ${data['BPJS']}"),
                            ]),
                      );
                          }
                          return const Text("loading");
                            },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
            );
  }

  Future<void> keluarDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xffffffff),
          title: const Text('Izin Keluar'),
          content: const SingleChildScrollView(
            child: Text(
              'Yakin ingin keluar ?',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const WelcomePage();
                }), ModalRoute.withName('/'));
              },
            ),
          ],
        );
      },
    );
  }
}
