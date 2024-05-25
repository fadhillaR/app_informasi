import 'dart:convert';

import 'package:app_informasi/model/ModelHukum.dart';
import 'package:app_informasi/screen_page/PageDetailHukum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageSearchHukum extends StatefulWidget {
  const PageSearchHukum({Key? key});

  @override
  State<PageSearchHukum> createState() => _PageSearchHukumState();
}

class _PageSearchHukumState extends State<PageSearchHukum> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _hukumList = [];
  List<dynamic> _filteredHukumList = [];

  @override
  void initState() {
    super.initState();
    fetchHukum();
  }

  Future<void> fetchHukum() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.6/informasiDb/getHukum.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _hukumList = responseData['data'];
        _filteredHukumList = _hukumList;
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }

  void _filterHukum(String query) {
    setState(() {
      _filteredHukumList = _hukumList
          .where((isi_laporan) =>
              isi_laporan['isi_laporan'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetail(dynamic hukumData) {
  Datum? hukum = Datum.fromJson(hukumData); 
  if (hukum != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageDetailHukum(hukum)),
    );
  } else {
    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cari Data Penyuluhan Hukum',
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
                _filterHukum(value);
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
              itemCount: _filteredHukumList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      '${_filteredHukumList[index]['isi_laporan']}',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => _navigateToDetail(_filteredHukumList[index]), 
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
