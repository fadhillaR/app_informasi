// To parse this JSON data, do
//
//     final modelJaksa = modelJaksaFromJson(jsonString);

import 'dart:convert';

ModelJaksa modelJaksaFromJson(String str) => ModelJaksa.fromJson(json.decode(str));

String modelJaksaToJson(ModelJaksa data) => json.encode(data.toJson());

class ModelJaksa {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelJaksa({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelJaksa.fromJson(Map<String, dynamic> json) => ModelJaksa(
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
    String idJms;
    String idUser;
    String namaPemohon;
    String namaSekolah;
    String statusLaporan;
    String nama;
    String nohp;
    String ktp;

    Datum({
        required this.idJms,
        required this.idUser,
        required this.namaPemohon,
        required this.namaSekolah,
        required this.statusLaporan,
        required this.nama,
        required this.nohp,
        required this.ktp,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idJms: json["id_jms"],
        idUser: json["id_user"],
        namaPemohon: json["nama_pemohon"],
        namaSekolah: json["nama_sekolah"],
        statusLaporan: json["status_laporan"],
        nama: json["nama"],
        nohp: json["nohp"],
        ktp: json["ktp"],
    );

    Map<String, dynamic> toJson() => {
        "id_jms": idJms,
        "id_user": idUser,
        "nama_pemohon": namaPemohon,
        "nama_sekolah": namaSekolah,
        "status_laporan": statusLaporan,
        "nama": nama,
        "nohp": nohp,
        "ktp": ktp,
    };
}
