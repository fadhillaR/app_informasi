import 'dart:convert';
import 'dart:core'; //validasi format email

import 'package:app_informasi/screen_page/PageLogin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNohp = TextEditingController();
  TextEditingController txtKtp = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtAlamat = TextEditingController();
  TextEditingController txtRole = TextEditingController(text: 'customer');
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool _obscureText = true;

  // Definisi regex untuk memeriksa format email
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<int> _register() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.6/informasiDb/register.php'),
        body: {
          "nama": txtNama.text,
          "email": txtEmail.text,
          "password": txtPassword.text,
          "alamat": txtAlamat.text,
          "nohp": txtNohp.text,
          "ktp": txtKtp.text,
          "role": txtRole.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final registerStatus = responseData['value'];

        return registerStatus ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 110, 97, 255), // Warna utama di tengah
                Color.fromARGB(
                    255, 110, 97, 255), // Warna transparan di pinggir
                Color.fromARGB(
                    255, 110, 97, 255), // Warna transparan di pinggir
                Color.fromARGB(255, 110, 97, 255), // Warna utama di tengah
              ],
              stops: [
                0.1,
                0.4,
                0.6,
                0.9
              ], // Menentukan ukuran masing-masing warna
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PageLogin()),
                              (route) => false);
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Warna border
                              width: 2, // Ketebalan border
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //logo
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Column(
                        //   children: [
                        //     Align(
                        //       alignment: Alignment.centerRight,
                        //       child: ColorFiltered(
                        //         colorFilter: ColorFilter.mode(
                        //           Color.fromARGB(255, 255, 213, 97)
                        //               .withOpacity(0.5),
                        //           BlendMode.srcATop,
                        //         ),
                        //         child: Image.asset(
                        //           'assets/bgboard.png',
                        //           width: 200,
                        //           height: 250,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),

                  Positioned(
                      top: 100,
                      left: 40,
                      right: 40,
                      bottom: 80,
                      child: SingleChildScrollView(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  30.0), // Melengkungkan ujung kiri atas
                              bottomRight: Radius.circular(
                                  30.0), // Melengkungkan ujung kanan bawah
                              topRight: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                            ),
                          ),
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Container(
                              width: 200,
                              height: 750,
                              constraints: BoxConstraints(
                                minHeight: 200,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: Text(
                                      'Create Account',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 85, 77, 181),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(35, 10, 20, 10),
                                    subtitle: Text(
                                      'Hello there, fill in below to create an account',
                                      style: TextStyle(
                                        color: Color(0xffA9A297),
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: keyForm,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 30,
                                          left: 30,
                                          top: 10,
                                          bottom: 10),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              validator: (val) {
                                                return val!.isEmpty
                                                    ? "Tidak Boleh kosong"
                                                    : null;
                                              },
                                              controller: txtNama,
                                              decoration: InputDecoration(
                                                fillColor:
                                                    Colors.grey.withOpacity(0.2),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                hintText: 'Enter nama lengkap',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                              ),
                                            ),
                                            
                                            
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return "Tidak Boleh kosong";
                                                } else if (!emailRegex
                                                    .hasMatch(val)) {
                                                  return "ex: ex@mail.com";
                                                }
                                                return null;
                                              },
                                              controller: txtEmail,
                                              decoration: InputDecoration(
                                                fillColor:
                                                    Colors.grey.withOpacity(0.2),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                hintText: 'Enter email address',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                              ),
                                            ),
                                            
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              validator: (val) {
                                                return val!.isEmpty
                                                    ? "Tidak Boleh kosong"
                                                    : null;
                                              },
                                              controller: txtNohp,
                                              decoration: InputDecoration(
                                                fillColor:
                                                    Colors.grey.withOpacity(0.2),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                // hintText: 'Enter username',
                                                hintText: 'Enter no hp',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                              ),
                                            ),
                                            
                                            
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              validator: (val) {
                                                return val!.isEmpty
                                                    ? "Tidak Boleh kosong"
                                                    : null;
                                              },
                                              controller: txtKtp,
                                              decoration: InputDecoration(
                                                fillColor:
                                                    Colors.grey.withOpacity(0.2),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                // hintText: 'Enter username',
                                                hintText: 'Enter no ktp',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                              ),
                                            ),
                                            
                                            
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              validator: (val) {
                                                return val!.isEmpty
                                                    ? "Tidak Boleh kosong"
                                                    : null;
                                              },
                                              controller: txtAlamat,
                                              decoration: InputDecoration(
                                                fillColor:
                                                    Colors.grey.withOpacity(0.2),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                hintText: 'Enter alamat',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                              ),
                                            ),
                            
                            
                                            // SizedBox(
                                            //   height: 5,
                                            // ),
                                            // TextFormField(
                                            //   style: TextStyle(
                                            //     fontSize: 12.0,
                                            //   ),
                                            //   validator: (val) {
                                            //     return val!.isEmpty
                                            //         ? "Tidak Boleh kosong"
                                            //         : null;
                                            //   },
                                            //   readOnly: true,
                                            //   controller: txtRole,
                                            //   decoration: InputDecoration(
                                            //     fillColor:
                                            //         Colors.grey.withOpacity(0.2),
                                            //     filled: true,
                                            //     border: OutlineInputBorder(
                                            //       borderSide: BorderSide.none,
                                            //       borderRadius: BorderRadius.all(
                                            //           Radius.circular(10)),
                                            //     ),
                                            //     hintText: 'Customer',
                                            //     contentPadding:
                                            //         EdgeInsets.symmetric(
                                            //             vertical: 10,
                                            //             horizontal: 20),
                                            //   ),
                                            // ),
                                            
                            
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              obscureText: _obscureText,
                                              validator: (val) {
                                                return val!.isEmpty
                                                    ? "Tidak Boleh kosong"
                                                    : null;
                                              },
                                              controller: txtPassword,
                                              decoration: InputDecoration(
                                                fillColor:
                                                    Colors.grey.withOpacity(0.2),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                hintText: 'Enter password',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _obscureText =
                                                          !_obscureText;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    _obscureText
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Color.fromARGB(
                                                        255, 74, 48, 0),
                                                    size: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            
                                            SizedBox(
                                              height: 25,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                if (keyForm.currentState
                                                        ?.validate() ==
                                                    true) {
                                                  _register()
                                                      .then((registerStatus) {
                                                    if (registerStatus == 1) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Berhasil didaftarkan!'),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      );
                                                      // Navigator
                                                      //     .pushReplacementNamed(
                                                      //         context,
                                                      //         '/PageLogin');
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PageLogin()),
                                                          (route) => false);
                                                    } else if (registerStatus ==
                                                        2) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Ktp atau email telah digunakan!'),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    } else if (registerStatus ==
                                                        0) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Gagal didaftarkan'),
                                                          backgroundColor:
                                                              Colors.deepOrange,
                                                        ),
                                                      );
                                                    } else {}
                                                  }).catchError((error) {
                                                    print(
                                                        "Error during login: $error");
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'An error occurred during login. Please try again later.'),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                  });
                                                }
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             PageLogin()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                backgroundColor: Color.fromARGB(
                                                    255, 85, 77, 181),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                minimumSize: Size(300, 40),
                                              ),
                                              child: Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: "I’m already a member ",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 85, 77, 181),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                        text: 'Log In',
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                PageLogin()));
                                                              },
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.bold))
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(right: 0),
                                  //   child: Container(
                                  //     width: 350,
                                  //     child:
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
