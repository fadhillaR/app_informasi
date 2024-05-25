import 'dart:convert';
import 'package:app_informasi/screen_page/PageListJaksa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateJaksa extends StatefulWidget {
  final String idJms;
  final String idUser;
  final String namaPemohon;
  final String namaSekolah;
  final String statusLaporan;
  
  const UpdateJaksa({
    required this.idJms,
    required this.idUser,
    required this.namaPemohon,
    required this.namaSekolah,
    required this.statusLaporan,
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateJaksa> createState() => _UpdateJaksaState();
}

class _UpdateJaksaState extends State<UpdateJaksa> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_pemohon = TextEditingController();
  TextEditingController nama_sekolah = TextEditingController();
  TextEditingController status_laporan = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController ktpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
    nama_pemohon.text = widget.namaPemohon;
    nama_sekolah.text = widget.namaSekolah;
    status_laporan.text = widget.statusLaporan;
  }

  Future<void> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nama = prefs.getString('nama');
    String? nohp = prefs.getString('nohp');
    String? ktp = prefs.getString('ktp');
    if (nama != null && nohp != null && ktp != null) {
      setState(() {
        namaController.text = nama;
        nohpController.text = nohp;
        ktpController.text = ktp;
      });
    }
  }

  Future<int> _update() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://192.168.100.6/informasiDb/updateJaksa.php'));
    request.fields['id_jms'] = widget.idJms;
    request.fields['id_user'] = widget.idUser;
    request.fields['nama_pemohon'] = nama_pemohon.text;
    request.fields['nama_sekolah'] = nama_sekolah.text;
    request.fields['status_laporan'] = status_laporan.text;

    var response = await request.send();
    if (response.statusCode == 200) {
      try {
        final responseData = jsonDecode(await response.stream.bytesToString());
        final value = responseData['value'];
        return value ?? 0;
      } catch (e) {
        print('Error decoding JSON: $e');
        return 0;
      }
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PageListJaksa()),
                (route) => false);
            // Navigator.pop(context);
          },
        ),
        toolbarHeight: 50,
        backgroundColor: Color.fromARGB(255, 216, 216, 216),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: 1000,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                color: Color.fromARGB(255, 216, 216, 216),
                padding: EdgeInsets.only(left: 8, top: 8, right: 8),
                child: Stack(children: [
                  Text(
                    '\t\tUpdate Data Jaksa Masuk Sekolah',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(30),
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // SizedBox(height: 20),
                        // TextFormField(
                        //   controller: namaController,
                        //   readOnly: true,
                        //   decoration: InputDecoration(
                        //     hintText: "Nama",
                        //     hintStyle: TextStyle(fontSize: 14),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // TextFormField(
                        //   controller: nohpController,
                        //   readOnly: true,
                        //   decoration: InputDecoration(
                        //     hintText: "Nomor HP",
                        //     hintStyle: TextStyle(fontSize: 14),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 10),
                        // TextFormField(
                        //   controller: ktpController,
                        //   readOnly: true,
                        //   decoration: InputDecoration(
                        //     hintText: "KTP",
                        //     hintStyle: TextStyle(fontSize: 14),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(),
                        //     ),
                        //   ),
                        // ),
                        
                        SizedBox(height: 30),
                        TextFormField(
                          controller: nama_pemohon,
                          // maxLines: null,
                          // keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Nama Pemohon",
                            hintStyle: TextStyle(fontSize: 14),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "nama pemohon tidak boleh kosong";
                            }
                          },
                        ),

                        SizedBox(height: 30),
                        TextFormField(
                          controller: nama_sekolah,
                          // maxLines: null,
                          // keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Nama Sekolah",
                            hintStyle: TextStyle(fontSize: 14),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "nama sekolah tidak boleh kosong";
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Color.fromARGB(255, 85, 77, 181),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _update().then((value) {
                                if (value == 1) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Berhasil update data Jaksa Masuk Sekolah!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => PageListJaksa()),
                                    ),
                                    (route) => false,
                                  );
                                } else if (value == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Gagal update data Jaksa Masuk Sekolah'),
                                      backgroundColor: Colors.deepOrange,
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          child: Text(
                            "Update Data",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
