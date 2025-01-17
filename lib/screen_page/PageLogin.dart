import 'dart:convert';

import 'package:app_informasi/admin/HomePageAdmin.dart';
import 'package:app_informasi/screen_page/HomePage.dart';
import 'package:app_informasi/screen_page/PageMenu.dart';
import 'package:app_informasi/screen_page/PageRegister.dart';
import 'package:app_informasi/screen_page/PageUtama.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  // bool isLoading = true;
  bool isLoading = false;
  bool _obscureText = true;

  // Definisi regex untuk memeriksa format email
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final email = txtEmail.text;
    final password = txtPassword.text;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.6/informasiDb/login.php'),
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // String idUser = responseData['data']['id_user'];
          prefs.setString('email', txtEmail.text);
          prefs.setString('password', txtPassword.text);
          prefs.setString('nama', responseData['data']['nama']);
          prefs.setString('nohp', responseData['data']['nohp']);
          prefs.setString('ktp', responseData['data']['ktp']);
          prefs.setString('alamat', responseData['data']['alamat']);
          prefs.setString('role', responseData['data']['role']);
          prefs.setString('id_user', responseData['data']['id_user']);
          // prefs.setString('idUser', idUser);

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => BottomNavigationPage()),
          // );

          String role = responseData['data']['role'];
          if (role == 'admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NavigationAdmin()),
            );
          } else if (role == 'customer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationPage()),
            );
          } else {
            // Default page if role is not recognized
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationPage()),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Login Gagal'),
                content: Text('Email atau Password salah.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Terjadi kesalahan saat melakukan login.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: 750,
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
                                  builder: (context) => MenuPage()),
                              (route) => false);
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
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
                  // Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Column(
                  //         children: [
                  //           // Align(
                  //           //   alignment: Alignment.centerRight,
                  //           //   child: ColorFiltered(
                  //           //     colorFilter: ColorFilter.mode(
                  //           //       Color.fromARGB(255, 255, 213, 97)
                  //           //           .withOpacity(0.5),
                  //           //       BlendMode.srcATop,
                  //           //     ),
                  //           //     child: Image.asset(
                  //           //       'assets/bgboard.png',
                  //           //       width: 200,
                  //           //       height: 250,
                  //           //     ),
                  //           //   ),
                  //           // ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),

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
                        child: Container(
                          width: 200,
                          height: 200,
                          constraints: BoxConstraints(
                            minHeight: 500,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Center(
                                child: Text(
                                  'Welcome Back',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 85, 77, 181),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    // fontFamily: 'Open Sans',
                                  ),
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.fromLTRB(35, 10, 20, 0),
                                subtitle: Text(
                                  'Hello there, Log in to continue!',
                                  style: TextStyle(
                                    color: Color(0xffA9A297),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 10, top: 0, bottom: 10, left: 10),
                                // padding: EdgeInsets.all(10),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: 350,
                                  child: Form(
                                    key: keyForm,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          // validator: (val) {
                                          //   return val!.isEmpty
                                          //       ? "Tidak Boleh kosong"
                                          //       : null;
                                          // },
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

                                        //passwordField
                                        SizedBox(
                                          height: 15,
                                        ),
                                        TextFormField(
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
                                                  _obscureText = !_obscureText;
                                                });
                                              },
                                              icon: Icon(
                                                _obscureText
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Color.fromARGB(
                                                    255, 85, 77, 181),
                                                size: 14.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //button
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                onPressed: isLoading ? null : () => _login(),
                                child: isLoading
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  backgroundColor:
                                      Color.fromARGB(255, 85, 77, 181),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: Size(260, 40),
                                ),
                              ),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => PageMulai()));
                              //   },
                              //   child: Text(
                              //     'Login',
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              //   style: ElevatedButton.styleFrom(
                              //     padding: EdgeInsets.symmetric(horizontal: 20),
                              //     backgroundColor:
                              //         Color.fromARGB(255, 85, 77, 181),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     minimumSize: Size(260, 40),
                              //   ),
                              // ),

                              //link
                              SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 85, 77, 181),
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'Sign up',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PageRegister()));
                                            },
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                            ],
                          ),
                        ),
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
