// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ticket {
  String hanhTrinh;
  String gioKhoiHanh;
  String diemDi;
  double giaVe;
  String khoanCach;

  String diemDen;
  int soGhe;
  int soGheConLai;
  String dcDiemDi;
  String dcDiemDen;
  int thoiGianDuKien;

  String? loaiChuyenXe;
  Ticket({
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
    this.loaiChuyenXe,
  });
}
