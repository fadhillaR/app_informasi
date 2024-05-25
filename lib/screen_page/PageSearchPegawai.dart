import 'dart:convert';

import 'package:app_informasi/model/ModelPegawai.dart';
import 'package:app_informasi/screen_page/PageDetailPegawai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageSearchPegawai extends StatefulWidget {
  const PageSearchPegawai({Key? key});

  @override
  State<PageSearchPegawai> createState() => _PageSearchPegawaiState();
}

class _PageSearchPegawaiState extends State<PageSearchPegawai> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _pegawaiList = [];
  List<dynamic> _filteredPegawaiList = [];

  @override
  void initState() {
    super.initState();
    fetchPegawai();
  }

  Future<void> fetchPegawai() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.6/informasiDb/getPegawai.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _pegawaiList = responseData['data'];
        _filteredPegawaiList = _pegawaiList;
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }

  void _filterPegawai(String query) {
    setState(() {
      _filteredPegawaiList = _pegawaiList
          .where((isi_laporan) =>
              isi_laporan['isi_laporan'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetail(dynamic pegawaiData) {
  Datum? pegawai = Datum.fromJson(pegawaiData); // Mengonversi JSON menjadi objek Datum
  if (pegawai != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageDetailPegawai(pegawai)),
    );
  } else {
    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cari Data Pengaduan Pegawai',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Color.fromARGB(255, 216, 216, 216),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _filterPegawai(value);
              },
              decoration: InputDecoration(
                labelText: 'search',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 85, 77, 181)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPegawaiList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      // 'Laporan ke - ${_filteredPegawaiList[index]['id_pegawai']}',
                      '${_filteredPegawaiList[index]['isi_laporan']}',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => _navigateToDetail(_filteredPegawaiList[index]), 
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
