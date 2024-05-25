import 'dart:convert';

import 'package:app_informasi/model/ModelJaksa.dart';
import 'package:app_informasi/screen_page/PageDetailJaksa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageSearchJaksa extends StatefulWidget {
  const PageSearchJaksa({Key? key});

  @override
  State<PageSearchJaksa> createState() => _PageSearchJaksaState();
}

class _PageSearchJaksaState extends State<PageSearchJaksa> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _jaksaList = [];
  List<dynamic> _filteredJaksaList = [];

  @override
  void initState() {
    super.initState();
    fetchJaksa();
  }

  Future<void> fetchJaksa() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.6/informasiDb/getJaksa.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _jaksaList = responseData['data'];
        _filteredJaksaList = _jaksaList;
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }

  void _filterJaksa(String query) {
    setState(() {
      _filteredJaksaList = _jaksaList
          .where((nama_pemohon) =>
              nama_pemohon['nama_pemohon'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetail(dynamic jaksaData) {
  Datum? jaksa = Datum.fromJson(jaksaData); 
  if (jaksa != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageDetailJaksa(jaksa)),
    );
  } else {
    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cari Data Jaksa Masuk Sekolah',
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
                _filterJaksa(value);
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
              itemCount: _filteredJaksaList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      '${_filteredJaksaList[index]['nama_pemohon']}',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => _navigateToDetail(_filteredJaksaList[index]), 
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
