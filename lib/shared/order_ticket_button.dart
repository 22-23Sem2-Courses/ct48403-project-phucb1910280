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
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            color: Colors.teal,
            width: 2,
          )),
      child: TextButton.icon(
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
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                              width: 60,
                              child: Divider(
                                color: Colors.grey,
                                thickness: 5,
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Số lượng:',
                                  style: TextStyle(fontSize: 25),
                                ),
                                const SizedBox(
                                  width: 40,
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
                                        const SizedBox(
                                          width: 10,
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
                                          width: 80,
                                          child: Center(
                                            child: Text(
                                              '$slVe vé',
                                              style:
                                                  const TextStyle(fontSize: 20),
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
                                        const SizedBox(
                                          width: 10,
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
                                const Text(
                                  'Tổng cộng:',
                                  style: TextStyle(fontSize: 25),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                          locale: 'vi-VN', decimalDigits: 0)
                                      .format(tong),
                                  style: const TextStyle(
                                      fontSize: 25,
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
          icon: const Icon(
            Icons.confirmation_num_outlined,
            size: 29,
            color: Colors.teal,
          ),
          label: const Text(
            'Đặt vé',
            style: TextStyle(color: Colors.teal, fontSize: 25),
          )),
    );
  }

  Widget cancelButton() {
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
        child: const Text(
          'Hủy',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget orderButton() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextButton(
        onPressed: () async {
          createUserTicketOrdered(slVe);
          createUserNotifications();
          createTicketOrdered(slVe);
        },
        child: const Text(
          'Đặt vé',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
