import 'dart:convert';

import 'package:app_informasi/model/ModelAliran.dart';
import 'package:app_informasi/screen_page/PageDetailAliran.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageSearchAliran extends StatefulWidget {
  const PageSearchAliran({Key? key});

  @override
  State<PageSearchAliran> createState() => _PageSearchAliranState();
}

class _PageSearchAliranState extends State<PageSearchAliran> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _aliranList = [];
  List<dynamic> _filteredAliranList = [];

  @override
  void initState() {
    super.initState();
    fetchAliran();
  }

  Future<void> fetchAliran() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.6/informasiDb/getAliran.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _aliranList = responseData['data'];
        _filteredAliranList = _aliranList;
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }

  void _filterAliran(String query) {
    setState(() {
      _filteredAliranList = _aliranList
          .where((isi_laporan) =>
              isi_laporan['isi_laporan'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetail(dynamic aliranData) {
  Datum? aliran = Datum.fromJson(aliranData); 
  if (aliran != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageDetailAliran(aliran)),
    );
  } else {
    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cari Data Pengawasan Aliran dan Kepercayaan',
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
                _filterAliran(value);
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
              itemCount: _filteredAliranList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      '${_filteredAliranList[index]['isi_laporan']}',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => _navigateToDetail(_filteredAliranList[index]), 
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
