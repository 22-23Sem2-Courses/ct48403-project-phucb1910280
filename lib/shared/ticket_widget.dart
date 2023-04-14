// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/ticket.dart';

class TicketWidget extends StatelessWidget {
  final Ticket ticket;
  const TicketWidget({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          SizedBox(
              width: s * 0.95,
              height: s * 0.42,
              child: Image.asset(
                'assets/images/${ticket.loaiChuyenXe}.png',
                fit: BoxFit.fitWidth,
              )),
          Positioned(
            top: s * 0.02,
            left: s * 0.04,
            child: Text(
              ticket.hanhTrinh,
              style: TextStyle(
                fontSize: s * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: s * 0.118,
            left: s * 0.075,
            child: Text(
              'Giờ khởi hành: ${ticket.gioKhoiHanhHienThi}',
              style: TextStyle(
                fontSize: s * 0.06,
              ),
            ),
          ),
          Positioned(
            top: s * 0.23,
            left: s * 0.075,
            child: Text(
              'Điểm đi: ${ticket.diemDi}',
              style: TextStyle(
                fontSize: s * 0.06,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: s * 0.33,
            left: s * 0.04,
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    NumberFormat.simpleCurrency(
                            locale: 'vi-VN', decimalDigits: 0)
                        .format(ticket.giaVe),
                    style: TextStyle(
                      fontSize: s * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(
                    width: s * 0.07,
                  ),
                  Text(
                    ticket.khoanCach,
                    style: TextStyle(
                      fontSize: s * 0.055,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: s * 0.07,
                  ),
                  Text(
                    'Chi tiết >>',
                    style: TextStyle(
                      fontSize: s * 0.06,
                      fontWeight: FontWeight.normal,
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
  }
}
