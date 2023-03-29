import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject_app/shared/ticket_detail.dart';
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
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              'Vé đi Hồ Chí Minh',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          SizedBox(
            height: 174,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TicketDetailScreen(
                                  hanhTrinh: 'Cần Thơ -> Sài Gòn',
                                  gioKhoiHanh: '7:20',
                                  diemDi: 'Bến xe 91B',
                                  giaVe: 165000,
                                  khoanCach: '160 km',
                                  diemDen: 'Bến xe Miền Tây',
                                  soGhe: 16,
                                  soGheConLai: 16,
                                  dcDiemDi:
                                      'QL 91B (Nguyễn Văn Linh), Hưng Lợi, Ninh Kiều, Tp Cần Thơ',
                                  dcDiemDen:
                                      '395 Kinh Đ. Vương, An Lạc, Bình Tân, Tp HCM',
                                  thoiGianDuKien: 4,
                                )));
                  },
                  child: const TicketWidget(
                      anhLoaiVe: 'veDiHCM',
                      hanhTrinh: 'Cần Thơ -> Sài Gòn',
                      gioKhoiHanh: '7:20',
                      diemDi: 'Bến xe 91B',
                      giaVe: 165000,
                      khoanCach: '160 km'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TicketDetailScreen(
                                  hanhTrinh: 'Sài Gòn -> Đà Lạt',
                                  gioKhoiHanh: '10:35',
                                  diemDi: 'Bến xe Miền Đông mới',
                                  giaVe: 300000,
                                  khoanCach: '310 km',
                                  diemDen: 'Bến xe Đà Lạt',
                                  soGhe: 16,
                                  soGheConLai: 11,
                                  dcDiemDi:
                                      '501 Hoàng Hữu Nam, p. Long Bình, TP Thủ Đức',
                                  dcDiemDen:
                                      '1 Tô Hiến Thành, Phường 3, Tp Đà Lạt, Lâm Đồng',
                                  thoiGianDuKien: 4,
                                )));
                  },
                  child: const TicketWidget(
                      anhLoaiVe: 'veDiHCM',
                      hanhTrinh: 'Sài Gòn -> Đà Lạt',
                      gioKhoiHanh: '10:35',
                      diemDi: 'Bến xe Miền Đông mới',
                      giaVe: 300000,
                      khoanCach: '310 km'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TicketDetailScreen(
                                  hanhTrinh: 'Sài Gòn -> Rạch Giá',
                                  gioKhoiHanh: '15:15',
                                  diemDi: 'Bến xe Miền Tây',
                                  giaVe: 190000,
                                  khoanCach: '235 km',
                                  diemDen: 'Bến xe Rạch Giá',
                                  soGhe: 16,
                                  soGheConLai: 15,
                                  dcDiemDi:
                                      '395 Kinh Đ. Vương, An Lạc, Bình Tân, Tp HCM',
                                  dcDiemDen:
                                      '260A Nguyễn Bỉnh Khiêm, Vĩnh Thanh, Rạch Giá, Kiên Giang',
                                  thoiGianDuKien: 4,
                                )));
                  },
                  child: const TicketWidget(
                      anhLoaiVe: 'veDiHCM',
                      hanhTrinh: 'Sài Gòn -> Rạch Giá',
                      gioKhoiHanh: '15:15',
                      diemDi: 'Bến xe Miền Tây',
                      giaVe: 190000,
                      khoanCach: '235 km'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TicketDetailScreen(
                                  hanhTrinh: 'Cà Mau -> Sài Gòn',
                                  gioKhoiHanh: '20:30',
                                  diemDi: 'Bến xe Miền Tây',
                                  giaVe: 230000,
                                  khoanCach: '347 km',
                                  diemDen: 'Bến xe Cà Mau',
                                  soGhe: 16,
                                  soGheConLai: 16,
                                  dcDiemDi:
                                      '395 Kinh Đ. Vương, An Lạc, Bình Tân, Tp HCM',
                                  dcDiemDen: ' QL 1A, phường 6, Tp Cà Mau',
                                  thoiGianDuKien: 4,
                                )));
                  },
                  child: const TicketWidget(
                      anhLoaiVe: 'veDiHCM',
                      hanhTrinh: 'Cà Mau -> Sài Gòn',
                      gioKhoiHanh: '20:30',
                      diemDi: 'Bến xe Miền Tây',
                      giaVe: 230000,
                      khoanCach: '347 km'),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Text(
              'Vé đi tỉnh khác',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TicketDetailScreen(
                                hanhTrinh: 'Cần Thơ -> Sài Gòn',
                                gioKhoiHanh: '7:20',
                                diemDi: 'Bến xe 91B',
                                giaVe: 165000,
                                khoanCach: '160 km',
                                diemDen: 'Bến xe Miền Tây',
                                soGhe: 16,
                                soGheConLai: 16,
                                dcDiemDi:
                                    'QL 91B (Nguyễn Văn Linh), Hưng Lợi, Ninh Kiều, Tp Cần Thơ',
                                dcDiemDen:
                                    '395 Kinh Đ. Vương, An Lạc, Bình Tân, Tp HCM',
                                thoiGianDuKien: 4,
                              )));
                },
                child: const TicketWidget(
                    anhLoaiVe: 'veDiTinhKhac',
                    hanhTrinh: 'Cần Thơ -> Sài Gòn',
                    gioKhoiHanh: '7:20',
                    diemDi: 'Bến xe 91B',
                    giaVe: 165000,
                    khoanCach: '160 km'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TicketDetailScreen(
                                hanhTrinh: 'Sài Gòn -> Đà Lạt',
                                gioKhoiHanh: '10:35',
                                diemDi: 'Bến xe Miền Đông mới',
                                giaVe: 300000,
                                khoanCach: '310 km',
                                diemDen: 'Bến xe Đà Lạt',
                                soGhe: 16,
                                soGheConLai: 11,
                                dcDiemDi:
                                    '501 Hoàng Hữu Nam, p. Long Bình, TP Thủ Đức',
                                dcDiemDen:
                                    '1 Tô Hiến Thành, Phường 3, Tp Đà Lạt, Lâm Đồng',
                                thoiGianDuKien: 4,
                              )));
                },
                child: const TicketWidget(
                    anhLoaiVe: 'veDiTinhKhac',
                    hanhTrinh: 'Sài Gòn -> Đà Lạt',
                    gioKhoiHanh: '10:35',
                    diemDi: 'Bến xe Miền Đông mới',
                    giaVe: 300000,
                    khoanCach: '310 km'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TicketDetailScreen(
                                hanhTrinh: 'Sài Gòn -> Rạch Giá',
                                gioKhoiHanh: '15:15',
                                diemDi: 'Bến xe Miền Tây',
                                giaVe: 190000,
                                khoanCach: '235 km',
                                diemDen: 'Bến xe Rạch Giá',
                                soGhe: 16,
                                soGheConLai: 15,
                                dcDiemDi:
                                    '395 Kinh Đ. Vương, An Lạc, Bình Tân, Tp HCM',
                                dcDiemDen:
                                    '260A Nguyễn Bỉnh Khiêm, Vĩnh Thanh, Rạch Giá, Kiên Giang',
                                thoiGianDuKien: 4,
                              )));
                },
                child: const TicketWidget(
                    anhLoaiVe: 'veDiTinhKhac',
                    hanhTrinh: 'Sài Gòn -> Rạch Giá',
                    gioKhoiHanh: '15:15',
                    diemDi: 'Bến xe Miền Tây',
                    giaVe: 190000,
                    khoanCach: '235 km'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TicketDetailScreen(
                                hanhTrinh: 'Cà Mau -> Sài Gòn',
                                gioKhoiHanh: '20:30',
                                diemDi: 'Bến xe Miền Tây',
                                giaVe: 230000,
                                khoanCach: '347 km',
                                diemDen: 'Bến xe Cà Mau',
                                soGhe: 16,
                                soGheConLai: 16,
                                dcDiemDi:
                                    '395 Kinh Đ. Vương, An Lạc, Bình Tân, Tp HCM',
                                dcDiemDen: ' QL 1A, phường 6, Tp Cà Mau',
                                thoiGianDuKien: 4,
                              )));
                },
                child: const TicketWidget(
                    anhLoaiVe: 'veDiTinhKhac',
                    hanhTrinh: 'Cà Mau -> Sài Gòn',
                    gioKhoiHanh: '20:30',
                    diemDi: 'Bến xe Miền Tây',
                    giaVe: 230000,
                    khoanCach: '347 km'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
