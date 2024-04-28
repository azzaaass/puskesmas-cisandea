import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puskesmas_cisadea/data/poli.dart';
import 'package:puskesmas_cisadea/user/get_queue.dart';
import 'package:puskesmas_cisadea/user/view_queue.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: const Color(0xFFeeedf2),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  child: Text("A"),
                ),
                const SizedBox(
                  width: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('userData')
                          .doc(uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error"),
                          );
                        }
                        if (snapshot.data!.exists) {
                          var data = snapshot.data!;
                          return Text(
                            data['username'],
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                          );
                        }
                        return const Text('-');
                      },
                    ),
                    Text(
                      'xxxx-xxxx-xxxx-xxxx',
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const Spacer(),
                const Badge(
                  smallSize: 10,
                  child: FaIcon(FontAwesomeIcons.bell),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi hari ini',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xFF568AF5),
                          Color(0xFF8CB7FD),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vaksin akan dilakukan!',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text(
                                'Lokasi di Puskesmas Cisadea',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 18),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF769FF2),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '30 April 2024',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            right: -15,
                            bottom: -5,
                            child: Image.asset('assets/images/doctor.png'))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'Daftar Poli',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listPoli.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetQueue(
                          poli: Poli(
                              name: listPoli[index].name,
                              slug: listPoli[index].slug,
                              doctor: listPoli[index].doctor,
                              logo: listPoli[index].logo),
                        ),
                      )),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    margin: const EdgeInsets.only(bottom: 10),
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
                          listPoli[index].logo,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listPoli[index].name,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              listPoli[index].doctor[0],
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewQueue(poli: listPoli[index]),
                              )),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color(0xFF568AF5),
                                  Color(0xFF8CB7FD),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.userGroup,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: Container(
        height: 30,
        color: const Color(0xFF6798f8),
        child: TextButton(
            onPressed: () async {
              // Auth
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Logout',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 200, 212, 237),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            )),
      ),
    );
  }
}
