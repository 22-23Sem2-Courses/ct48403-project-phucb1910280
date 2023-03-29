// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:myproject_app/shared/order_ticket_button.dart';

class TicketDetailScreen extends StatelessWidget {
  final String hanhTrinh;
  final String gioKhoiHanh;
  final String diemDi;
  final double giaVe;
  final String khoanCach;

  final String diemDen;
  final int soGhe;
  final int soGheConLai;
  final String dcDiemDi;
  final String dcDiemDen;
  final int thoiGianDuKien;

  const TicketDetailScreen({
    Key? key,
    required this.hanhTrinh,
    required this.gioKhoiHanh,
    required this.diemDi,
    required this.giaVe,
    required this.khoanCach,
    required this.diemDen,
    required this.soGhe,
    required this.soGheConLai,
    required this.dcDiemDi,
    required this.dcDiemDen,
    required this.thoiGianDuKien,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(hanhTrinh),
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
                      diemDi,
                      style: const TextStyle(fontSize: 25, color: Colors.teal),
                    ),
                  ),
                  Positioned(
                    top: 43,
                    left: 50,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        dcDiemDi,
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
                          khoanCach,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 30,
                          child: Center(child: Text('~')),
                        ),
                        Text(
                          '$thoiGianDuKien tiếng',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 148,
                    left: 50,
                    child: Text(
                      diemDen,
                      style: const TextStyle(fontSize: 25, color: Colors.teal),
                    ),
                  ),
                  Positioned(
                    top: 178,
                    left: 50,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        dcDiemDen,
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
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Giờ khởi hành: $gioKhoiHanh',
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Loại xe: Ford Transit 16 chỗ',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Còn lại: $soGheConLai chỗ',
                style: const TextStyle(fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Giá vé: $giaVe VND',
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: OrderTicketButton(giaVe: giaVe, soGheConLai: soGheConLai),
      ),
    );
  }
}
