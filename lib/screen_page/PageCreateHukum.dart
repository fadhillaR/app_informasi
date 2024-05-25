import 'dart:convert';
import 'package:app_informasi/screen_page/PageListHukum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class createHukum extends StatefulWidget {
  const createHukum({Key? key}) : super(key: key);

  @override
  State<createHukum> createState() => _createHukumState();
}

class _createHukumState extends State<createHukum> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_user = TextEditingController();
  TextEditingController isi_laporan = TextEditingController();
  TextEditingController status_laporan =
      TextEditingController(text: 'Pending');
  PlatformFile? _selectedFile; // menyimpan file terpilih
  PlatformFile? _selectedKTPFile;
  TextEditingController namaController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController ktpController = TextEditingController();

  @override
void initState() {
  super.initState();
  _getUserId();
}

Future<void> _getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('id_user');
  String? nama = prefs.getString('nama');
  String? nohp = prefs.getString('nohp');
  String? ktp = prefs.getString('ktp');
  if (userId != null && nama != null && nohp != null && ktp != null) {
    setState(() {
      id_user.text = userId;
      namaController.text = nama;
      nohpController.text = nohp;
      ktpController.text = ktp;
    });
  }
}

  Future<int> _simpan() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://192.168.100.6/informasiDb/createHukum.php'));
    request.fields['id_user'] = id_user.text;
    request.fields['isi_laporan'] = isi_laporan.text;
    request.fields['status_laporan'] = status_laporan.text;

    // Menambahkan file laporan
    if (_selectedFile != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'laporan',
          _selectedFile!.bytes!,
          filename: _selectedFile!.name,
        ),
      );
    } else {
      
    }

    // Menambahkan file KTP
    if (_selectedKTPFile != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'file_ktp',
          _selectedKTPFile!.bytes!,
          filename: _selectedKTPFile!.name,
        ),
      );
    } else {
      
    }

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

  // memilih file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _pickKTPFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedKTPFile = result.files.first;
      });
    } else {
      // User canceled the picker
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
                MaterialPageRoute(builder: (context) => PageListHukum()),
                (route) => false);
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
                    '\t\tTambah Data Penyuluhan Hukum',
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

                        // data user
                          SizedBox(height: 20),
                          TextFormField(
                            controller: namaController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Nama",
                              hintStyle: TextStyle(fontSize: 14),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: nohpController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Nomor HP",
                              hintStyle: TextStyle(fontSize: 14),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: ktpController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "KTP",
                              hintStyle: TextStyle(fontSize: 14),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),

                          SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _pickKTPFile,
                          child: Text("Pilih File KTP"),
                        ),
                        SizedBox(height: 10),
                        _selectedKTPFile != null
                            ? Text(_selectedKTPFile!.name)
                            : Container(),

                        SizedBox(height: 30),
                        TextFormField(
                          controller: isi_laporan,
                          // maxLines: null,
                          // keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Judul Laporan",
                            hintStyle: TextStyle(fontSize: 14),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "judul laporan tidak boleh kosong";
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _pickFile,
                          child: Text("Pilih File"),
                        ),
                        SizedBox(height: 10),
                        _selectedFile != null
                            ? Text(_selectedFile!.name)
                            : Container(),

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
                              _simpan().then((value) {
                                if (value == 1) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Berhasil tambah data Penyuluhan Hukum!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => PageListHukum()),
                                    ),
                                    (route) => false,
                                  );
                                } else if (value == 2) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Nama telah digunakan!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else if (value == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Gagal tambah data Penyuluhan Hukum'),
                                      backgroundColor: Colors.deepOrange,
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          child: Text(
                            "Simpan Data",
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
