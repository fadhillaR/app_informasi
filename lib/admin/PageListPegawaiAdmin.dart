import 'package:app_informasi/admin/HomePageAdmin.dart';
import 'package:app_informasi/admin/detail/DetailPegawai.dart';
import 'package:app_informasi/admin/search/SearchPegawai.dart';
import 'package:app_informasi/model/ModelPegawai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:intl/intl.dart';

class ListPegawaiAdmin extends StatefulWidget {
  const ListPegawaiAdmin({super.key});

  @override
  State<ListPegawaiAdmin> createState() => _ListPegawaiAdminState();
}

class _ListPegawaiAdminState extends State<ListPegawaiAdmin> {
  Future<List<Datum>?> getPegawai() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response res = await http
          .get(Uri.parse('http://192.168.100.6/informasiDb/getPegawai.php'));
      return modelPegawaiFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationAdmin()),
                (route) => false);
          },
        ),
        toolbarHeight: 50,
        backgroundColor: Color.fromARGB(255, 216, 216, 216),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPegawaiAdmin();
              }));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              color: Color.fromARGB(255, 216, 216, 216),
              padding: EdgeInsets.only(left: 8, top: 8, right: 8),
              child: Stack(children: [
                Text(
                  '\t\tPengaduan Pegawai',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: getPegawai(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Datum>?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        Datum? data = snapshot.data?[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Card(
                              elevation: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPegawaiAdmin(data)),
                                  ).then((value) {
                                    if (value != null && value is String) {
                                      setState(() {});
                                    }
                                  });
                                },
                                child: Stack(
                                  children: [
                                    ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5),
                                            Text(
                                              // "Laporan ke-${data?.idPegawai}",
                                              "${data?.isiLaporan}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 74, 48, 0),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Status : ${data?.statusLaporan}",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff468CE7),
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}