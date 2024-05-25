// To parse this JSON data, do
//
//     final modelPilkada = modelPilkadaFromJson(jsonString);

import 'dart:convert';

ModelPilkada modelPilkadaFromJson(String str) => ModelPilkada.fromJson(json.decode(str));

String modelPilkadaToJson(ModelPilkada data) => json.encode(data.toJson());

class ModelPilkada {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelPilkada({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelPilkada.fromJson(Map<String, dynamic> json) => ModelPilkada(
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
    String idPilkada;
    String idUser;
    String fileKtp;
    String isiLaporan;
    String laporan;
    String statusLaporan;
    String nama;
    String nohp;
    String ktp;

    Datum({
        required this.idPilkada,
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
        idPilkada: json["id_pilkada"],
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
        "id_pilkada": idPilkada,
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
