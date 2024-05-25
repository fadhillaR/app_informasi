import 'package:app_informasi/model/ModelPegawai.dart';
import 'package:app_informasi/screen_page/PageListPegawai.dart';
import 'package:app_informasi/screen_page/PageUpdatePegawai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class PageDetailPegawai extends StatelessWidget {
  final Datum? data;

  const PageDetailPegawai(this.data, {super.key});

  Future<bool> _deletePegawai(String idPegawai) async {
    final response = await http.post(
      Uri.parse('http://192.168.100.6/informasiDb/deletePegawai.php'),
      body: {
        "id_pegawai": idPegawai,
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
                _deletePegawai(data?.idPegawai ?? '').then((isSuccess) {
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
                            builder: (context) => PageListPegawai()),
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

  Future<void> _viewPDF(BuildContext context, String fileName) async {
    final url = 'http://192.168.100.6/informasiDb/file/$fileName';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                            return UpdatePegawai(
                              idPegawai: data?.idPegawai ?? '',
                              idUser: data?.idUser ?? '',
                              fileKtp: data?.fileKtp ?? '',
                              isiLaporan: data?.isiLaporan ?? '',
                              statusLaporan: data?.statusLaporan ?? '',
                              laporan: data?.laporan ?? '',
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
                  data?.isiLaporan ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  data?.fileKtp ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _viewPDF(context, data?.fileKtp ?? '');
                  },
                  child: Text('Lihat File KTP'),
                ),
                SizedBox(height: 10),
                Text(
                  data?.laporan ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _viewPDF(context, data?.laporan ?? '');
                  },
                  child: Text('Lihat File Laporan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
