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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          Image.asset('assets/images/${ticket.loaiChuyenXe}.png'),
          Positioned(
            top: 12,
            left: 15,
            child: Text(
              ticket.hanhTrinh,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Positioned(
            top: 47,
            left: 35,
            child: Text(
              'Giờ khởi hành: ${ticket.gioKhoiHanhHienThi}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
            top: 95,
            left: 35,
            child: Text(
              'Điểm đi: ${ticket.diemDi}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 15,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    NumberFormat.simpleCurrency(
                            locale: 'vi-VN', decimalDigits: 0)
                        .format(ticket.giaVe),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    ticket.khoanCach,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    'Chi tiết >>',
                    style: TextStyle(
                      fontSize: 20,
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
