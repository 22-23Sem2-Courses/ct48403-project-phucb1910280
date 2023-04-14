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
    var s = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vé xe của tôi', style: TextStyle(fontSize: s * 0.05)),
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
                  child: Center(
                    child: Stack(
                      children: [
                        SizedBox(
                            width: s * 0.95,
                            child: Image.asset(
                              'assets/images/veXe.png',
                              fit: BoxFit.fitWidth,
                            )),
                        Positioned(
                          top: s * 0.028,
                          left: s * 0.05,
                          child: Text(
                            snapshot.data!.docs[index]['hanhTrinh'],
                            style: TextStyle(
                              fontSize: s * 0.06,
                            ),
                          ),
                        ),
                        Positioned(
                          top: s * 0.12,
                          left: s * 0.08,
                          child: Text(
                            'Giờ đi: ${snapshot.data!.docs[index]['gioKhoiHanhHienThi']}, ${snapshot.data!.docs[index]['ngayKhoiHanhHienThi']}',
                            style: TextStyle(
                              fontSize: s * 0.05,
                            ),
                          ),
                        ),
                        Positioned(
                          top: s * 0.2,
                          left: s * 0.08,
                          child: Text(
                            'Điểm đi: ${snapshot.data!.docs[index]['diemDi']}',
                            style: TextStyle(
                              fontSize: s * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Positioned(
                          top: s * 0.32,
                          left: s * 0.08,
                          child: Text(
                            'Điểm đến: ${snapshot.data!.docs[index]['diemDen']}',
                            style: TextStyle(
                              fontSize: s * 0.05,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          top: s * 0.40,
                          left: s * 0.08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data!.docs[index]['khoanCach']
                                    .toString(),
                                style: TextStyle(
                                  fontSize: s * 0.05,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Dự kiến: ${snapshot.data!.docs[index]['thoiGianDuKien']} tiếng đi xe',
                                style: TextStyle(
                                  fontSize: s * 0.05,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: s * 0.49,
                          left: s * 0.05,
                          child: SizedBox(
                            width: s * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Số vé: ${snapshot.data!.docs[index]['soVe'].toString()}',
                                  style: TextStyle(
                                    fontSize: s * 0.05,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: s * 0.30,
                                ),
                                Text(
                                  'Tổng: ${NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(snapshot.data!.docs[index]['tongTienVe'])}',
                                  style: TextStyle(
                                    fontSize: s * 0.05,
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
