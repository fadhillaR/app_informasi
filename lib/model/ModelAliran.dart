// To parse this JSON data, do
//
//     final modelAliran = modelAliranFromJson(jsonString);

import 'dart:convert';

ModelAliran modelAliranFromJson(String str) => ModelAliran.fromJson(json.decode(str));

String modelAliranToJson(ModelAliran data) => json.encode(data.toJson());

class ModelAliran {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelAliran({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelAliran.fromJson(Map<String, dynamic> json) => ModelAliran(
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
    String idAliran;
    String idUser;
    String fileKtp;
    String isiLaporan;
    String laporan;
    String statusLaporan;
    String nama;
    String nohp;
    String ktp;

    Datum({
        required this.idAliran,
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
        idAliran: json["id_aliran"],
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
        "id_aliran": idAliran,
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
