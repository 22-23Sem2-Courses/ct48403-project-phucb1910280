import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketWidget extends StatelessWidget {
  final String anhLoaiVe;
  final String hanhTrinh;
  final String gioKhoiHanh;
  final String diemDi;
  final double giaVe;
  final String khoanCach;
  const TicketWidget({
    Key? key,
    required this.anhLoaiVe,
    required this.hanhTrinh,
    required this.gioKhoiHanh,
    required this.diemDi,
    required this.giaVe,
    required this.khoanCach,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          Image.asset('assets/images/$anhLoaiVe.png'),
          Positioned(
            top: 12,
            left: 15,
            child: Text(
              hanhTrinh,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Positioned(
            top: 47,
            left: 35,
            child: Text(
              'Giờ khởi hành: $gioKhoiHanh',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Positioned(
            top: 95,
            left: 35,
            child: Text(
              'Điểm đi: $diemDi',
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
                        .format(giaVe),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    khoanCach,
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