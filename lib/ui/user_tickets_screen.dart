import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserTicketsScreen extends StatefulWidget {
  const UserTicketsScreen({super.key});

  @override
  State<UserTicketsScreen> createState() => _UserTicketsScreenState();
}

class _UserTicketsScreenState extends State<UserTicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vé xe của tôi', style: TextStyle(fontSize: 25)),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('XBusCustomers')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('userTicketsOrdered')
            .orderBy('id', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount:
                  snapshot.data!.docs.isEmpty ? 0 : snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/veXe.png'),
                      Positioned(
                        top: 10,
                        left: 15,
                        child: Text(
                          snapshot.data!.docs[index]['hanhTrinh'],
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 47,
                        left: 35,
                        child: Text(
                          'Giờ đi: ${snapshot.data!.docs[index]['gioKhoiHanhHienThi']}, ${snapshot.data!.docs[index]['ngayKhoiHanhHienThi']}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 35,
                        child: Text(
                          'Điểm đi: ${snapshot.data!.docs[index]['diemDi']}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 122,
                        left: 35,
                        child: Text(
                          'Điểm đến: ${snapshot.data!.docs[index]['diemDen']}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 155,
                        left: 35,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['khoanCach']
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Dự kiến: ${snapshot.data!.docs[index]['thoiGianDuKien']} tiếng đi xe',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 190,
                        left: 15,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Số vé: ${snapshot.data!.docs[index]['soVe'].toString()}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(
                                  width: 25,
                                ),
                              ),
                              Text(
                                'Tổng: ${NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(snapshot.data!.docs[index]['tongTienVe'])}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
