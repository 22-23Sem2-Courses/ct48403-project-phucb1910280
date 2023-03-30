// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:myproject_app/shared/order_ticket_button.dart';

import '../models/ticket.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailScreen({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(ticket.hanhTrinh),
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
                      ticket.diemDi,
                      style: const TextStyle(fontSize: 25, color: Colors.teal),
                    ),
                  ),
                  Positioned(
                    top: 43,
                    left: 50,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        ticket.dcDiemDi,
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
                          ticket.khoanCach,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 30,
                          child: Center(child: Text('~')),
                        ),
                        Text(
                          '${ticket.thoiGianDuKien} tiếng',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 148,
                    left: 50,
                    child: Text(
                      ticket.diemDen,
                      style: const TextStyle(fontSize: 25, color: Colors.teal),
                    ),
                  ),
                  Positioned(
                    top: 178,
                    left: 50,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        ticket.dcDiemDen,
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
            detailInfo('Giờ khởi hành', ticket.gioKhoiHanh,
                setTealColor: true, setBold: true),
            detailInfo('Loại xe', 'Ford Transit 16 chỗ'),
            detailInfo('Số ghế trống', ticket.soGheConLai.toString(),
                setTealColor: true, setBold: true),
            detailInfo(
                'Giá vé',
                NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                    .format(ticket.giaVe)
                    .toString(),
                setTealColor: true,
                setBold: true),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: OrderTicketButton(
            giaVe: ticket.giaVe, soGheConLai: ticket.soGheConLai),
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
