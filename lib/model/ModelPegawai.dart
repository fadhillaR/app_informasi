// To parse this JSON data, do
//
//     final modelPegawai = modelPegawaiFromJson(jsonString);

import 'dart:convert';

ModelPegawai modelPegawaiFromJson(String str) => ModelPegawai.fromJson(json.decode(str));

String modelPegawaiToJson(ModelPegawai data) => json.encode(data.toJson());

class ModelPegawai {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelPegawai({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelPegawai.fromJson(Map<String, dynamic> json) => ModelPegawai(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String idPegawai;
    String idUser;
    String fileKtp;
    String isiLaporan;
    String laporan;
    String statusLaporan;
    String nama;
    String nohp;
    String ktp;

    Datum({
        required this.idPegawai,
        required this.idUser,
        required this.fileKtp,
        required this.isiLaporan,
        required this.laporan,
        required this.statusLaporan,
        required this.nama,
        required this.nohp,
        required this.ktp,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idPegawai: json["id_pegawai"],
        idUser: json["id_user"],
        fileKtp: json["file_ktp"],
        isiLaporan: json["isi_laporan"],
        laporan: json["laporan"],
        statusLaporan: json["status_laporan"],
        nama: json["nama"],
        nohp: json["nohp"],
        ktp: json["ktp"],
    );

    Map<String, dynamic> toJson() => {
        "id_pegawai": idPegawai,
        "id_user": idUser,
        "file_ktp": fileKtp,
        "isi_laporan": isiLaporan,
        "laporan": laporan,
        "status_laporan": statusLaporan,
        "nama": nama,
        "nohp": nohp,
        "ktp": ktp,
    };
}
