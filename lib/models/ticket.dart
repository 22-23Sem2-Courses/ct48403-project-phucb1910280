// ignore_for_file: public_member_api_docs, sort_constructors_first
class Ticket {
  String? id;
  String hanhTrinh;
  String maHanhTrinh;
  String gioKhoiHanhHienThi;
  String gioKhoiHanhSoSanh;
  String? ngayKhoiHanhHienThi;
  String? ngayKhoiHanhSoSanh;
  String diemDi;
  double giaVe;
  String khoanCach;
  String diemDen;
  int soGhe;
  int? soGheConLai;
  String dcDiemDi;
  String dcDiemDen;
  int thoiGianDuKien;
  String? loaiChuyenXe;

  Ticket({
    this.id,
    required this.hanhTrinh,
    required this.maHanhTrinh,
    required this.gioKhoiHanhHienThi,
    required this.gioKhoiHanhSoSanh,
    this.ngayKhoiHanhHienThi,
    this.ngayKhoiHanhSoSanh,
    required this.diemDi,
    required this.giaVe,
    required this.khoanCach,
    required this.diemDen,
    required this.soGhe,
    this.soGheConLai,
    required this.dcDiemDi,
    required this.dcDiemDen,
    required this.thoiGianDuKien,
    this.loaiChuyenXe,
  });
}
