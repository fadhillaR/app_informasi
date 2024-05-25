import 'dart:convert';
import 'package:app_informasi/screen_page/HomePage.dart';
import 'package:app_informasi/screen_page/PageProfil.dart';
import 'package:app_informasi/screen_page/SidePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class createRating extends StatefulWidget {
  const createRating({Key? key}) : super(key: key);

  @override
  State<createRating> createState() => _createRatingState();
}

class _createRatingState extends State<createRating> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_user = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController komen = TextEditingController();
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
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.100.6/informasiDb/createRating.php'));
    request.fields['id_user'] = id_user.text;
    request.fields['rating'] = ratingController.text;
    request.fields['komen'] = komen.text;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => BottomNavigationPage()),
            //     (route) => route.isFirst);
            Navigator.pop(context);
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
                    '\t\tBeri Rating Aplikasi',
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
                        SizedBox(height: 30),
                        // TextFormField(
                        //   controller: rating,
                        //   // maxLines: null,
                        //   // keyboardType: TextInputType.multiline,
                        //   decoration: InputDecoration(
                        //     hintText: "enter rating",
                        //     hintStyle: TextStyle(fontSize: 14),
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return "rating tidak boleh kosong";
                        //     }
                        //   },
                        // ),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              // Update the rating controller with the selected rating
                              ratingController.text = rating.toString();
                            });
                          },
                        ),

                        SizedBox(height: 30),
                        TextFormField(
                          controller: komen,
                          // maxLines: null,
                          // keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "enter komen",
                            hintStyle: TextStyle(fontSize: 14),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "komen tidak boleh kosong";
                            }
                          },
                        ),

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
                                      content: Text(
                                          'Berhasil tambah submit rating!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => BottomNavigationPage()),
                                    ),
                                    (route) => false,
                                  );
                                } else if (value == 2) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Rating telah diberikan!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else if (value == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Gagal tambah submit rating'),
                                      backgroundColor: Colors.deepOrange,
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          child: Text(
                            "Submit",
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
