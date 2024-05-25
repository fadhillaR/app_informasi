// To parse this JSON data, do
//
//     final modelHukum = modelHukumFromJson(jsonString);

import 'dart:convert';

ModelHukum modelHukumFromJson(String str) => ModelHukum.fromJson(json.decode(str));

String modelHukumToJson(ModelHukum data) => json.encode(data.toJson());

class ModelHukum {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelHukum({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelHukum.fromJson(Map<String, dynamic> json) => ModelHukum(
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
    String idHukum;
    String idUser;
    String fileKtp;
    String isiLaporan;
    String laporan;
    String statusLaporan;
    String nama;
    String nohp;
    String ktp;

    Datum({
        required this.idHukum,
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
        idHukum: json["id_hukum"],
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
        "id_hukum": idHukum,
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
