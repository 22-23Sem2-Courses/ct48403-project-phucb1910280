import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject_app/shared/ticket_widget.dart';

class TicketOverviewScreen extends StatelessWidget {
  const TicketOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Vé xe hôm nay'),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
        body: ListView(
          children: const [
            TicketWidget(
                hanhTrinh: 'Cần Thơ -> Sài Gòn',
                gioKhoiHanh: '7:20',
                diemDonKhach: 'Bến xe 91B',
                giaVe: '165.000đ',
                khoanCach: '166 km'),
            TicketWidget(
                hanhTrinh: 'Sài Gòn -> Đà Lạt',
                gioKhoiHanh: '10:35',
                diemDonKhach: 'Bến xe Miền Đông mới',
                giaVe: '300.000đ',
                khoanCach: '310 km'),
            TicketWidget(
                hanhTrinh: 'Sài Gòn -> Rạch Giá',
                gioKhoiHanh: '15:15',
                diemDonKhach: 'Bến xe Miền Tây',
                giaVe: '190.000đ',
                khoanCach: '235 km'),
            TicketWidget(
                hanhTrinh: 'Cà Mau -> Sài Gòn',
                gioKhoiHanh: '20:30',
                diemDonKhach: 'Bến xe Miền Tây',
                giaVe: '230.000đ',
                khoanCach: '347 km'),
          ],
        ));
  }
}
