import 'package:app_informasi/screen_page/PageListAliran.dart';
import 'package:app_informasi/screen_page/PageListHukum.dart';
import 'package:app_informasi/screen_page/PageListJaksa.dart';
import 'package:app_informasi/screen_page/PageListKorupsi.dart';
import 'package:app_informasi/screen_page/PageListPegawai.dart';
import 'package:app_informasi/screen_page/PageListPilkada.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class PageMulai extends StatefulWidget {
  const PageMulai({super.key});

  @override
  State<PageMulai> createState() => _PageMulaiState();
}

class _PageMulaiState extends State<PageMulai> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back button
        toolbarHeight: 0, //app bar height
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: 900,
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //card
                  Positioned(
                    top: -170,
                    right: -500,
                    left: -500,
                    child: Image(
                      image: AssetImage(
                        'assets/Whistleblower_Home-1.png',
                      ),
                      width: 600,
                      height: 600,
                    ),
                  ),

                  //judul
                  Positioned(
                    top: 350,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pusat Informasi\nKejaksaan Tinggi Sumatera Barat',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: ('Open Sans'),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),


                  //rekomendasi
                  Positioned(
                    top: 430,
                    left: 20,
                    child: Row(
                      children: [
                        Text(
                          '| ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 85, 77, 181),
                              fontFamily: ('Open Sans'),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Telusuri',
                          style: TextStyle(
                              fontFamily: ('Open Sans'),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  //menu items
                  Positioned(
                    top: 460,
                    left: 60,
                    right: 60,
                    // left: MediaQuery.of(context).size.width / 5 - 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 85, 77, 181)
                                      .withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PageListPegawai()),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 13,),
                                  Image.asset(
                                    'assets/Pengaduan.png',
                                    width: 100,
                                    height: 70,
                                  ),
                                  SizedBox(height: 17),
                                  Text(
                                    'Pengaduan\nPegawai',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 85, 77, 181),
                                        fontSize: 10,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 85, 77, 181)
                                      .withOpacity(0.2), // Warna bayangan
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PageListKorupsi()),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 13,
                                  ),
                                  Image.asset(
                                    'assets/Pengaduan.png',
                                    width: 100,
                                    height: 70,
                                  ),
                                  SizedBox(height: 17),
                                  Text(
                                    'Pengaduan Tindak\nPidana Korupsi',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 85, 77, 181),
                                        fontSize: 10,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 85, 77, 181)
                                      .withOpacity(0.2), // Warna bayangan
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PageListJaksa()),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 13),
                                  Image.asset(
                                    'assets/Pengaduan.png',
                                    width: 100,
                                    height: 70,
                                  ),
                                  SizedBox(height: 17),
                                  Text(
                                    'JMS (Jaksa\nMasuk Sekolah)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 85, 77, 181),
                                        fontSize: 10,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //menu items
                  Positioned(
                    top: 630,
                    left: 60,
                    right: 60,
                    // left: MediaQuery.of(context).size.width / 5 - 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 85, 77, 181)
                                      .withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PageListHukum()),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 13),
                                  Image.asset(
                                    'assets/Pengaduan.png',
                                    width: 100,
                                    height: 70,
                                  ),
                                  SizedBox(height: 17),
                                  Text(
                                    'Penyuluhan\nHukum',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 85, 77, 181),
                                        fontSize: 10,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                          
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 85, 77, 181)
                                      .withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PageListAliran()),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 13),
                                  Image.asset(
                                    'assets/Pengaduan.png',
                                    width: 100,
                                    height: 70,
                                  ),
                                  SizedBox(height: 17),
                                  Text(
                                    'Pengawasan Aliran\ndan Kepercayaan',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 85, 77, 181),
                                        fontSize: 10,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                          
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 85, 77, 181)
                                      .withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PageListPilkada()),
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(height: 13),
                                  Image.asset(
                                    'assets/Pengaduan.png',
                                    width: 100,
                                    height: 70,
                                  ),
                                  SizedBox(height: 17),
                                  Text(
                                    'Posko\nPilkada',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 85, 77, 181),
                                        fontSize: 10,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
