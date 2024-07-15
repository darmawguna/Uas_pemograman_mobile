class HistoriData {
  int? historiId;
  DateTime? waktuKejadian;
  DateTime? waktuAsesmen;
  String? waktuLaporan;
  String? waktuTiba;
  String? jenisKejadian;
  String? lokasi;
  String? koordinat;
  int? meninggal;
  int? lukaBerat;
  int? lukaRingan;
  String? korban;
  String? perkiraanKerugian;
  String? keterangan;
  String? level;
  String? dokumentasiPath;

  HistoriData({
    this.historiId,
    this.waktuKejadian,
    this.waktuAsesmen,
    this.waktuLaporan,
    this.waktuTiba,
    this.jenisKejadian,
    this.lokasi,
    this.koordinat,
    this.meninggal,
    this.lukaBerat,
    this.lukaRingan,
    this.korban,
    this.perkiraanKerugian,
    this.keterangan,
    this.level,
    this.dokumentasiPath,
  });

  factory HistoriData.fromJson(Map<String, dynamic> json) => HistoriData(
        historiId: json["histori_id"],
        waktuKejadian: json["waktu_kejadian"] != null
            ? DateTime.parse(json["waktu_kejadian"])
            : null,
        waktuAsesmen: json["waktu_asesmen"] != null
            ? DateTime.parse(json["waktu_asesmen"])
            : null,
        waktuLaporan: json["waktu_laporan"],
        waktuTiba: json["waktu_tiba"],
        jenisKejadian: json["jenis_kejadian"],
        lokasi: json["lokasi"],
        koordinat: json["koordinat"],
        meninggal: json["meninggal"],
        lukaBerat: json["luka_berat"],
        lukaRingan: json["luka_ringan"],
        korban: json["korban"],
        perkiraanKerugian: json["perkiraan_kerugian"],
        keterangan: json["keterangan"],
        level: json["level"],
        dokumentasiPath: json["dokumentasi_path"],
      );

  Map<String, dynamic> toJson() => {
        "histori_id": historiId,
        "waktu_kejadian": waktuKejadian?.toIso8601String(),
        "waktu_asesmen": waktuAsesmen?.toIso8601String(),
        "waktu_laporan": waktuLaporan,
        "waktu_tiba": waktuTiba,
        "jenis_kejadian": jenisKejadian,
        "lokasi": lokasi,
        "koordinat": koordinat,
        "meninggal": meninggal,
        "luka_berat": lukaBerat,
        "luka_ringan": lukaRingan,
        "korban": korban,
        "perkiraan_kerugian": perkiraanKerugian,
        "keterangan": keterangan,
        "level": level,
        "dokumentasi_path": dokumentasiPath,
      };
}
