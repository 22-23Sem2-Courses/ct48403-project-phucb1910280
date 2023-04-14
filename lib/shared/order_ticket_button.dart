// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject_app/ui/home_page.dart';

import '../models/ticket.dart';

class OrderTicketButton extends StatefulWidget {
  final Ticket ticket;

  const OrderTicketButton({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  State<OrderTicketButton> createState() => _OrderTicketButtonState();
}

class _OrderTicketButtonState extends State<OrderTicketButton> {
  int slVe = 0;
  double tong = 0.0;

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size.width;
    return Container(
      height: s * 0.14,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            color: Colors.teal,
            width: 2,
          )),
      child: TextButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return SizedBox(
                      height: s * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              width: s * 0.2,
                              child: const Divider(
                                color: Colors.grey,
                                thickness: 5,
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Số lượng:',
                                  style: TextStyle(fontSize: s * 0.05),
                                ),
                                SizedBox(
                                  width: s * 0.2,
                                ),
                                Expanded(
                                  // child: ticketsQuantity(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.teal,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: s * 0.05,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (slVe > 0) {
                                                setState(() {
                                                  slVe--;
                                                  tong -= widget.ticket.giaVe;
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.remove)),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        SizedBox(
                                          width: s * 0.2,
                                          child: Center(
                                            child: Text(
                                              '$slVe vé',
                                              style:
                                                  TextStyle(fontSize: s * 0.05),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (slVe <
                                                  widget.ticket.soGheConLai!) {
                                                setState(() {
                                                  slVe++;
                                                  tong += widget.ticket.giaVe;
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.add)),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Tổng cộng:',
                                  style: TextStyle(fontSize: s * 0.05),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                          locale: 'vi-VN', decimalDigits: 0)
                                      .format(tong),
                                  style: TextStyle(
                                      fontSize: s * 0.05,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Expanded(child: cancelButton()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: orderButton()),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Text(
            'Đặt vé',
            style: TextStyle(color: Colors.teal, fontSize: s * 0.06),
          )),
    );
  }

  Widget cancelButton() {
    var s = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Hủy',
          style: TextStyle(
            color: Colors.teal,
            fontSize: s * 0.05,
          ),
        ),
      ),
    );
  }

  Widget orderButton() {
    var s = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextButton(
        onPressed: () async {
          if (slVe > 0) {
            createUserTicketOrdered(slVe);
            createUserNotifications();
            createTicketOrdered(slVe);
          } else {
            showDialog(
              barrierDismissible: true,
              barrierColor: Colors.black45,
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  content: Text(
                    'Vui lòng chọn số lượng vé',
                    style: TextStyle(fontSize: s * 0.035),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: s * 0.035),
                        )),
                  ],
                );
              },
            );
          }
        },
        child: Text(
          'Đặt vé',
          style: TextStyle(
            color: Colors.white,
            fontSize: s * 0.05,
          ),
        ),
      ),
    );
  }

  Future createTicketOrdered(int soLuongVe) async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('TicketsOrdered');
    return collectionRef.doc(widget.ticket.id).set({
      'id': widget.ticket.id,
      'hanhTrinh': widget.ticket.hanhTrinh,
      'maHanhTrinh': widget.ticket.maHanhTrinh,
      'gioKhoiHanhHienThi': widget.ticket.gioKhoiHanhHienThi,
      'ngayKhoiHanhHienThi': widget.ticket.ngayKhoiHanhHienThi,
      'diemDi': widget.ticket.diemDi,
      'giaVe': widget.ticket.giaVe,
      'khoanCach': widget.ticket.khoanCach,
      'diemDen': widget.ticket.diemDen,
      'soGhe': widget.ticket.soGhe,
      'soGheConLai': widget.ticket.soGheConLai! - soLuongVe,
      'dcDiemDi': widget.ticket.dcDiemDi,
      'dcDiemDen': widget.ticket.dcDiemDen,
      'thoiGianDuKien': widget.ticket.thoiGianDuKien,
      'loaiChuyenXe': widget.ticket.loaiChuyenXe,
    }).then((value) {
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black45,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: const Text('Đặt vé thành công!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  pageIndex: 0,
                                )),
                        (route) => false);
                  },
                  child: const Text('Về trang chủ')),
            ],
          );
        },
      );
    });
  }

  Future createUserTicketOrdered(int soLuongVe) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('XBusCustomers')
        .doc(currentUser!.email)
        .collection('userTicketsOrdered');
    return collectionRef
        .doc(DateFormat('dd-MM-yyyy-HH-mm-ss').format(DateTime.now()))
        .set({
      'id': widget.ticket.id,
      'hanhTrinh': widget.ticket.hanhTrinh,
      'gioKhoiHanhHienThi': widget.ticket.gioKhoiHanhHienThi,
      'ngayKhoiHanhHienThi': widget.ticket.ngayKhoiHanhHienThi,
      'diemDi': widget.ticket.diemDi,
      'giaVe': widget.ticket.giaVe,
      'khoanCach': widget.ticket.khoanCach,
      'diemDen': widget.ticket.diemDen,
      'thoiGianDuKien': widget.ticket.thoiGianDuKien,
      'soVe': soLuongVe,
      'tongTienVe': soLuongVe * widget.ticket.giaVe,
    });
  }

  Future createUserNotifications() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('XBusCustomers')
        .doc(currentUser!.email)
        .collection('userNotifications');
    return collectionRef
        .doc(DateFormat('dd-MM-yyyy-HH-mm-ss').format(DateTime.now()))
        .set({
      'id': DateFormat('dd-MM-yyyy-HH-mm-ss').format(DateTime.now()),
      'tieuDe': 'Đặt vé thành công',
      'noiDung': 'Vui lòng đến nhà xe trước 10\' để ổn định chỗ ngồi',
      'daDoc': 'chua',
      'thoiGian': DateFormat('HH:mm, dd/MM').format(DateTime.now()),
    });
  }
}
