import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puskesmas_cisadea/admin/update_queue.dart';
import 'package:puskesmas_cisadea/data/data_queue.dart';
import 'package:puskesmas_cisadea/data/poli.dart';

class ViewQueue extends StatelessWidget {
  final Poli poli;
  const ViewQueue({super.key, required this.poli});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFeeedf2),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      // listPoli[index].name,
                      'Lihat daftar antrean',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: const Color(0xFFf5f5f5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      poli.logo,
                      size: 30,
                      color: const Color(0xFF6798f8),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // listPoli[index].name,
                          poli.name,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          poli.doctor[0],
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: const Color(0xFFf5f5f5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(2, 2))
                      ],
                      borderRadius: BorderRadius.circular(5)),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(poli.slug)
                        .orderBy("queue", descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }
                      var data = snapshot.data!.docs;

                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            DataQueue dataQueue = DataQueue(
                                collection: poli.slug,
                                queue: data[index]['queue'],
                                rm: data[index]['rm'],
                                bpjs: data[index]['bpjs'],
                                nik: data[index]['nik'],
                                nama: data[index]['nama'],
                                ttl: data[index]['ttl'],
                                alamat: data[index]['alamat'],
                                tujuan: data[index]['tujuan'],
                                keluhan: data[index]['keluhan']);
                            return TextBox(
                              id: data[index].id,
                              poli: poli,
                              dataQueue: dataQueue,
                            );
                          });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )));
  }
}

class TextBox extends StatelessWidget {
  final String id;
  final Poli poli;
  final DataQueue dataQueue;
  TextBox(
      {super.key,
      required this.id,
      required this.poli,
      required this.dataQueue});

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    return Column(
      children: [
        InkWell(
          onDoubleTap: () {
            FirebaseFirestore.instance
                .collection('userData')
                .doc(uid)
                .get()
                .then((DocumentSnapshot doc) {
              // print(value);
              final data = doc.data() as Map<String, dynamic>;
              // print(data['role']);
              if (data['role'] == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateQueue(
                        poli: poli,
                        dataQueue: dataQueue,
                      ),
                    ));
                // print('auth_service ase');
              }
            });
          },
          child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              alignment: Alignment.centerLeft,
              // height: 50,
              decoration: BoxDecoration(
                  color: (id == uid) ? Colors.yellow : Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Antrean : ${dataQueue.queue.toString()}',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    dataQueue.nama.toString(),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
