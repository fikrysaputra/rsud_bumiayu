// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rsudbumiayu/dashboard.dart';

import 'auth.dart';
//import './dashboard.dart';

class IsiDataPasien extends StatefulWidget {
  const IsiDataPasien({Key? key}) : super(key: key);

  @override
  MengisiDataPasien createState() => MengisiDataPasien();
}

class MengisiDataPasien extends State<IsiDataPasien> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController namaPasien = TextEditingController();
    TextEditingController umurPasien = TextEditingController();
    TextEditingController tanggalLahir = TextEditingController();
    TextEditingController alamatPasien = TextEditingController();
    TextEditingController bpjspasien = TextEditingController();
    //TextEditingController tanggalKontrol = TextEditingController();
    //TextEditingController tanggalPeriksa = TextEditingController();

    CollectionReference datapasien =
        FirebaseFirestore.instance.collection('DataPasien');

    Future<void> tambahDataPasien() {
      return datapasien
          .doc(email)
          .set({
            'Nama_Pasien': namaPasien.text,
            'Umur': umurPasien.text,
            'Tanggal_Lahir': tanggalLahir.text,
            'Alamat': alamatPasien.text,
            'BPJS': bpjspasien.text,
          })
          .then((value) => print("Data ditambahkan"))
          .catchError((error) => print("Gagal menambahkan: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Isi Data Pasien"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2DA6AB),
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
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<DocumentSnapshot>(
              future: datapasien.doc(email).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return ListView(
                    children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: namaPasien,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Nama',
                            labelText: 'Nama',
                            icon: Icon(
                              Icons.account_box_outlined,
                              color: Colors.white,
                            ),
                          ),
                          onSaved: (String? value) {
                            namaPasien;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            controller: umurPasien,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              filled: true,
                              suffixText: 'tahun',
                              labelText: 'Umur',
                              icon: Icon(
                                Icons.date_range_sharp,
                                color: Colors.white,
                              ),
                            ),
                            onSaved: (String? value) {
                              umurPasien;
                            }),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            controller: tanggalLahir,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              filled: true,
                              hintText: 'Tanggal Lahir',
                              labelText: 'Tanggal Lahir',
                              icon: Icon(
                                Icons.date_range_outlined,
                                color: Colors.white,
                              ),
                            ),
                            onSaved: (String? value) {
                              tanggalLahir;
                            }),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            controller: alamatPasien,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              filled: true,
                              hintText: 'Alamat',
                              labelText: 'Alamat',
                              icon: Icon(
                                Icons.location_city,
                                color: Colors.white,
                              ),
                            ),
                            onSaved: (String? value) {
                              alamatPasien;
                            }),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            controller: bpjspasien,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              filled: true,
                              hintText: 'Ada atau tidak ada',
                              labelText: 'BPJS',
                              icon: Icon(
                                Icons.location_city,
                                color: Colors.white,
                              ),
                            ),
                            onSaved: (String? value) {
                              bpjspasien;
                            }),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Container(
                              height: 50,
                              width: 200.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  tambahDataPasien();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) {
                                    return const Dashboard();
                                  }), ModalRoute.withName('/daftarreview'));
                                },
                                child: const Center(
                                  child: Text(
                                    "Konfirmasi",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    ]
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color:Color(0xffffffff),
                    ),
                    child: 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        const Text("Data anda sudah diisi!"),
                        Text("Nama : ${data['Nama_Pasien']}"),
                        Text("Umur : ${data['Umur']}"),
                        Text("Tangga Lahir : ${data['Tanggal_Lahir']}"),
                        Text("Alamat : ${data['Alamat']}"),
                        Text("BPJS : ${data['BPJS']}"),
                        ]
                      ),
                  );
                }
                return const Text("loading");
              },
            ),
          ),
        ),
      ),
    );
  }
}
