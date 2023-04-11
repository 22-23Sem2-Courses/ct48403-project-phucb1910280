// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:myproject_app/shared/order_ticket_button.dart';

import '../models/ticket.dart';

class TicketDetailScreen extends StatefulWidget {
  final Ticket ticket;

  const TicketDetailScreen({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  String daySelected = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      var currentDay = DateTime.now();
      String currentDayFormatted = DateFormat('yyyy-MM-dd').format(currentDay);
      widget.ticket.id = '$currentDayFormatted-${widget.ticket.maHanhTrinh}';
      widget.ticket.ngayKhoiHanhSoSanh =
          '$currentDayFormatted ${widget.ticket.gioKhoiHanhSoSanh}';
    });
    checkIfCanOrderToday(
        widget.ticket.ngayKhoiHanhSoSanh!, DateTime.now().toString());
    checkExistTicketsOrdered(widget.ticket.id!);
  }

  void showDateTimePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    ).then((dateTime) {
      String currentDayFormatted = DateFormat('yyyy-MM-dd').format(dateTime!);
      setState(() {
        widget.ticket.id = '$currentDayFormatted-${widget.ticket.maHanhTrinh}';
        widget.ticket.ngayKhoiHanhHienThi =
            '${dateTime.day}/${dateTime.month}/${dateTime.year}';
        checkExistTicketsOrdered(widget.ticket.id!);
      });
    });
  }

  void checkExistTicketsOrdered(String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection('TicketsOrdered')
          .doc(widget.ticket.id)
          .get()
          .then((value) {
        setState(() {
          widget.ticket.soGheConLai = value['soGheConLai'];
        });
      });
    } catch (e) {
      setState(() {
        widget.ticket.soGheConLai = 16;
      });
    }
  }

  void checkIfCanOrderToday(String fixedDateTime, String currentDateTime) {
    DateTime fDT = DateTime.parse(fixedDateTime);
    DateTime cDT = DateTime.parse(currentDateTime);
    if (cDT.isBefore(fDT)) {
      setState(() {
        widget.ticket.ngayKhoiHanhHienThi =
            '${cDT.day}/${cDT.month}/${cDT.year}';
        String currentDayFormatted = DateFormat('yyyy-MM-dd').format(cDT);
        widget.ticket.id = '$currentDayFormatted-${widget.ticket.maHanhTrinh}';
      });
    } else {
      String tomorrow = '${cDT.day + 1}';
      String thisMonth = cDT.month < 10 ? '0${cDT.month}' : '${cDT.month}';
      String idPrefix = '${fDT.year}-$thisMonth-$tomorrow';
      setState(() {
        widget.ticket.ngayKhoiHanhHienThi =
            '${cDT.day + 1}/${cDT.month}/${cDT.year}';
        widget.ticket.id = '$idPrefix-${widget.ticket.maHanhTrinh}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.ticket.hanhTrinh),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Image.asset(
                      'assets/images/ticket_detail_frame.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    top: 13,
                    left: 50,
                    child: Text(
                      widget.ticket.diemDi,
                      style: const TextStyle(fontSize: 25, color: Colors.teal),
                    ),
                  ),
                  Positioned(
                    top: 43,
                    left: 50,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        widget.ticket.dcDiemDi,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 105,
                    left: 70,
                    child: Row(
                      children: [
                        Text(
                          widget.ticket.khoanCach,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 30,
                          child: Center(child: Text('~')),
                        ),
                        Text(
                          '${widget.ticket.thoiGianDuKien} tiếng',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 148,
                    left: 50,
                    child: Text(
                      widget.ticket.diemDen,
                      style: const TextStyle(fontSize: 25, color: Colors.teal),
                    ),
                  ),
                  Positioned(
                    top: 178,
                    left: 50,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        widget.ticket.dcDiemDen,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            detailInfo('Giờ khởi hành', widget.ticket.gioKhoiHanhHienThi,
                setTealColor: true, setBold: true),
            detailInfo('Ngày', widget.ticket.ngayKhoiHanhHienThi,
                setTealColor: true, setBold: true),
            detailInfo('Loại xe', 'Ford Transit 16 chỗ'),
            detailInfo('Số ghế trống', widget.ticket.soGheConLai.toString(),
                setTealColor: true, setBold: true),
            detailInfo(
                'Giá vé',
                NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                    .format(widget.ticket.giaVe)
                    .toString(),
                setTealColor: true,
                setBold: true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDateTimePicker(context);
        },
        icon: const Icon(Icons.calendar_month_outlined),
        label: const Text(
          'Chọn ngày',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: OrderTicketButton(ticket: widget.ticket),
      ),
    );
  }

  Widget detailInfo(String key, dynamic value,
      {bool setTealColor = false, bool setBold = false}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$key:',
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: setBold ? FontWeight.bold : FontWeight.normal,
              color: setTealColor ? Colors.teal : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
