import 'dart:convert' as convert;

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:spacex_latest_launch/api_response.dart';
import 'package:spacex_latest_launch/custom_clipper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX Latest Launch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[600],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<ApiResponse> apiResponse;
  late Future<Links> links;

  Future<ApiResponse> fetchResponse() async {
    // https://api.spacexdata.com/v4/launches/latest

    final url = Uri.https(
      "api.spacexdata.com",
      "/v4/launches/latest",
    );
    final response = await http.get(url);
    final jsonResponseBody = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(jsonResponseBody);
    } else {
      throw Exception("An error accured on fetchResponse()");
    }
  }

  Future<Links> fetchLinks() async {
    final url = Uri.https(
      "api.spacexdata.com",
      "/v4/launches/latest",
    );
    final response = await http.get(url);
    final jsonResponseBody = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Links.fromJson(jsonResponseBody["links"]);
    } else {
      throw Exception("An error accured on fetchResponse()");
    }
  }

  @override
  void initState() {
    apiResponse = fetchResponse();
    links = fetchLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SpaceX"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 35),
            Text(
              "Latest SpaceX Launch",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 35),
            Container(
              width: 350,
              height: 450,
              child: SingleChildScrollView(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  shadowColor: Colors.grey,
                  color: Colors.white,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        child: Container(
                          color: Colors.grey,
                          child: Row(
                            children: [
                              ClipPath(
                                clipper: MyCustomClipper(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                  ),
                                  child: Container(
                                    height: 50,
                                    width: 230,
                                    color: Colors.grey[700],
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Center(
                                        child: FutureBuilder<ApiResponse>(
                                          future: apiResponse,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                snapshot.data!.name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: FutureBuilder<Links>(
                          future: links,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Image.network(snapshot.data!.patch.small);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FutureBuilder<ApiResponse>(
                          future: apiResponse,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.details,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.grey,
                                ),
                              ),
                            );
                          },
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
      // bottomNavigationBar: ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     primary: Colors.grey[900],
      //   ),
      //   onPressed: () {
      //     // fetchResponse();
      //     fetchLinks();
      //   },
      //   child: Text("Print Response"),
      // ),
    );
  }
}
