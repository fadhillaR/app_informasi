import 'package:app_informasi/screen_page/PageLogin.dart';
import 'package:app_informasi/screen_page/PageRegister.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          Positioned(
            top: -170,
            right: -70,
            left: -70,
            child: Image(
              image: AssetImage(
                'assets/Whistleblower_Home-1.png',
              ),
              width: 600,
              height: 600,
            ),
          ),
          Positioned(
            top: 340,
            left: 30,
            child: Text(
              'Welcome...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Open Sans'),
            ),
          ),
          Positioned(
            top: 380,
            left: 30,
            child: Text(
              'Aplikasi Pusat Informasi\nSilahkan Login terlebih dahulu...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 425,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PageLogin()));
                  },
                  child: Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 85, 77, 181),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Icons.person,
                        //   color: Color.fromARGB(255, 74, 48, 0),
                        //   size: 20,
                        // ),
                        // SizedBox(width: 10),
                        Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                    => PageRegister()
                    ));
                  },
                  child: Container(
                    width: 400,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          // Color.fromARGB(255, 134, 169, 255),
                          // Color.fromARGB(255, 54, 111, 255),
                          // Color.fromARGB(255, 51, 109, 253),
                          Color.fromARGB(255, 85, 77, 181),
                          Color.fromARGB(255, 85, 77, 181),
                          Color.fromARGB(255, 85, 77, 181),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          color: Colors.white,
                          // color: Color(0xff333333),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
