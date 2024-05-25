import 'package:app_informasi/model/ModelJaksa.dart';
import 'package:app_informasi/screen_page/PageListJaksa.dart';
import 'package:app_informasi/screen_page/PageUpdateJaksa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class PageDetailJaksa extends StatelessWidget {
  final Datum? data;

  const PageDetailJaksa(this.data, {super.key});

  Future<bool> _deleteJaksa(String idJms) async {
    final response = await http.post(
      Uri.parse('http://192.168.100.6/informasiDb/deleteJaksa.php'),
      body: {
        "id_jms": idJms,
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['isSuccess'];
    }
    return false;
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            "Apakah yakin menghapus data?",
            style: TextStyle(color: Color.fromARGB(255, 74, 48, 0)),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _deleteJaksa(data?.idJms ?? '').then((isSuccess) {
                  Navigator.of(context).pop();
                  if (isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data Berhasil Dihapus'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageListJaksa()),
                        (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data Gagal Dihapus'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 85, 77, 181),
              ),
              child: Text(
                "Hapus",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Batal",
                style: TextStyle(
                  color: Color.fromARGB(255, 85, 77, 181),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPending = data?.statusLaporan == "Pending";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 216, 216, 216),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              data?.nama ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              data?.statusLaporan ?? "",
              style: TextStyle(
                color: Color.fromARGB(255, 85, 77, 181),
                fontSize: 11,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Menampilkan tombol edit jika status laporan "pending"
                if (isPending)
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UpdateJaksa(
                              idJms: data?.idJms ?? '',
                              idUser: data?.idUser ?? '',
                              namaPemohon: data?.namaPemohon ?? '',
                              namaSekolah: data?.namaSekolah ?? '',
                              statusLaporan: data?.statusLaporan ?? '',
                            );
                          },
                        ),
                      );
                    },
                  ),
                // Menampilkan tombol hapus jika status laporan "pending"
                if (isPending)
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _confirmDelete(context);
                    },
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 216, 216, 216),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
                top: Radius.circular(20),
              ),
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Pemohon\t: ${data?.namaPemohon ?? ""}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Sekolah\t:\n${data?.namaSekolah ?? ""}",
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
