import 'dart:convert';

import 'package:app_informasi/admin/detail/DetailKorupsi.dart';
import 'package:app_informasi/model/ModelKorupsi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchKorupsiAdmin extends StatefulWidget {
  const SearchKorupsiAdmin({Key? key});

  @override
  State<SearchKorupsiAdmin> createState() => _SearchKorupsiAdminState();
}

class _SearchKorupsiAdminState extends State<SearchKorupsiAdmin> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _korupsiList = [];
  List<dynamic> _filteredKorupsiList = [];

  @override
  void initState() {
    super.initState();
    fetchKorupsi();
  }

  Future<void> fetchKorupsi() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.6/informasiDb/getKorupsi.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _korupsiList = responseData['data'];
        _filteredKorupsiList = _korupsiList;
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }

  void _filterKorupsi(String query) {
    setState(() {
      _filteredKorupsiList = _korupsiList
          .where((isi_laporan) =>
              isi_laporan['isi_laporan'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetail(dynamic korupsiData) {
  Datum? korupsi = Datum.fromJson(korupsiData); 
  if (korupsi != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailKorupsiAdmin(korupsi)),
    );
  } else {
    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cari Data Pengaduan Tindak Pidana Korupsi',
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
                _filterKorupsi(value);
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
              itemCount: _filteredKorupsiList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      // 'Laporan ke - ${_filteredKorupsiList[index]['id_korupsi']}',
                      '${_filteredKorupsiList[index]['isi_laporan']}',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => _navigateToDetail(_filteredKorupsiList[index]), 
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
