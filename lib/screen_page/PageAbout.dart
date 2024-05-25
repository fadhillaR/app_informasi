import 'package:flutter/material.dart';

class PageAbout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 216, 216, 216),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 216, 216, 216),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
                top: Radius.circular(10),
              ),
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aplikasi Pusat Informasi adalah sebuah platform digital yang bertujuan untuk memberikan aksesibilitas yang lebih baik kepada masyarakat terhadap informasi dan layanan yang disediakan oleh institusi kejaksaan. Kami berkomitmen untuk memberikan layanan yang terbaik dalam mendukung upaya penegakan hukum, pencegahan tindak pidana, serta peningkatan keadilan bagi seluruh masyarakat.'
                ),
                SizedBox(height: 10),
                Text(
                  '\nVisi Kami:\nMenjadi aplikasi yang menjadi solusi terpercaya dalam memberikan layanan hukum yang mudah diakses dan memberikan kontribusi positif dalam penegakan hukum, perlindungan masyarakat, serta peningkatan kesadaran hukum di Indonesia.'
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
