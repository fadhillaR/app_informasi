import 'dart:convert';

import 'package:app_informasi/admin/detail/DetailPilkada.dart';
import 'package:app_informasi/model/ModelPilkada.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPilkadaAdmin extends StatefulWidget {
  const SearchPilkadaAdmin({Key? key});

  @override
  State<SearchPilkadaAdmin> createState() => _SearchPilkadaAdminState();
}

class _SearchPilkadaAdminState extends State<SearchPilkadaAdmin> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _pilkadaList = [];
  List<dynamic> _filteredPilkadaList = [];

  @override
  void initState() {
    super.initState();
    fetchPilkada();
  }

  Future<void> fetchPilkada() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.6/informasiDb/getPilkada.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _pilkadaList = responseData['data'];
        _filteredPilkadaList = _pilkadaList;
      });
    } else {
      throw Exception('Failed to load Data');
    }
  }

  void _filterPilkada(String query) {
    setState(() {
      _filteredPilkadaList = _pilkadaList
          .where((isi_laporan) =>
              isi_laporan['isi_laporan'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetail(dynamic pilkadaList) {
  Datum? pilkada = Datum.fromJson(pilkadaList); 
  if (pilkada != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPilkadaAdmin(pilkada)),
    );
  } else {
    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cari Data Pengawasan pilkada dan Kepercayaan',
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
                _filterPilkada(value);
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
              itemCount: _filteredPilkadaList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      '${_filteredPilkadaList[index]['isi_laporan']}',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => _navigateToDetail(_filteredPilkadaList[index]), 
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
