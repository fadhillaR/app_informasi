import 'package:app_informasi/admin/PageListJaksaAdmin.dart';
import 'package:app_informasi/model/ModelJaksa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class DetailJaksaAdmin extends StatefulWidget {
  final Datum? data;

  const DetailJaksaAdmin(this.data, {Key? key}) : super(key: key);

  @override
  _DetailJaksaAdminState createState() => _DetailJaksaAdminState();
}

class _DetailJaksaAdminState extends State<DetailJaksaAdmin> {
  Future<bool> _updateStatusLaporan(
    String idJms,
    String statusLaporan,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.6/informasiDb/updateStatusJMS.php'),
        body: {
          "id_jms": idJms,
          "status_laporan": statusLaporan,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final value = responseData['value'];
        return (value == 1);
      } else {
        throw Exception(
            'Failed to update status. HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update status. Error: $error');
    }
  }

  void _editStatusLaporan(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String selectedStatus = widget.data?.statusLaporan ?? 'Pending';
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Status Laporan'),
              content: DropdownButton<String>(
                value: selectedStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue!;
                  });
                },
                items: <String>['Pending', 'Approved', 'Rejected']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    _updateStatusLaporan(
                      widget.data?.idJms ?? '',
                      selectedStatus,
                    ).then((isSuccess) {
                      if (isSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Status Berhasil Diupdate'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListJaksaAdmin()),
                            (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gagal memperbarui status'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal memperbarui status: $error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
              ],
            );
          },
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 216, 216, 216),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editStatusLaporan(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              widget.data?.nama ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              widget.data?.statusLaporan ?? "",
              style: TextStyle(
                color: Color.fromARGB(255, 85, 77, 181),
                fontSize: 11,
              ),
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
                  "Nama Pemohon\t: ${widget.data?.namaPemohon ?? ""}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Sekolah\t:\n${widget.data?.namaSekolah ?? ""}",
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