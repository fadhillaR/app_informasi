import 'package:app_informasi/model/ModelRating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ListRating extends StatefulWidget {
  const ListRating({Key? key});

  @override
  State<ListRating> createState() => _ListRatingState();
}

class _ListRatingState extends State<ListRating> {
  late Future<List<Datum>?> _ratingFuture;

  @override
  void initState() {
    super.initState();
    _ratingFuture = getRating();
  }

  Future<List<Datum>?> getRating() async {
    try {
      http.Response res = await http.get(Uri.parse('http://192.168.100.6/informasiDb/getRating.php'));
      return modelRatingFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  double calculateAverageRating(List<Datum>? data) {
    int totalRating = 0;
    if (data != null) {
      for (var rating in data) {
        totalRating += rating.rating;
      }
      if (data.isNotEmpty) {
        return totalRating / data.length;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 50,
        backgroundColor: Color.fromARGB(255, 216, 216, 216),
        iconTheme: IconThemeData(color: Colors.black),
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
              child: Stack(
                children: [
                  Text(
                    '\t\tRating User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: FutureBuilder(
                      future: _ratingFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(color: Colors.orange);
                        } else if (snapshot.hasData) {
                          double averageRating = calculateAverageRating(snapshot.data);
                          return Text(
                            'Average Rating: ${averageRating.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error fetching data',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          );
                        } else {
                          return Text('');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: _ratingFuture,
                builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.orange));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        Datum? data = snapshot.data?[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 1,
                                child: InkWell(
                                  onTap: () {},
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5),
                                          Text(
                                            "${data?.nama}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(255, 74, 48, 0),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Rate : ${data?.rating}",
                                            style: TextStyle(
                                              color: Color(0xff468CE7),
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            "Komentar : ${data?.komen}",
                                            style: TextStyle(
                                              color: Color(0xff468CE7),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: CircularProgressIndicator(color: Colors.orange));
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
