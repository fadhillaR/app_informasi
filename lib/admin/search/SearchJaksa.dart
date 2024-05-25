import 'dart:convert';

import 'package:app_informasi/admin/detail/DetailJaksa.dart';
import 'package:app_informasi/model/ModelJaksa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchJaksaAdmin extends StatefulWidget {
  const SearchJaksaAdmin({Key? key});

  @override
  State<SearchJaksaAdmin> createState() => _SearchJaksaAdminState();
}

class _SearchJaksaAdminState extends State<SearchJaksaAdmin> {
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
      MaterialPageRoute(builder: (context) => DetailJaksaAdmin(jaksa)),
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
