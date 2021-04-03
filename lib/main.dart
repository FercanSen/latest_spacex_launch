import 'dart:convert' as convert;

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:spacex_latest_launch/api_response.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  Future<ApiResponse> fetchResponse() async {
    final url = Uri.https(
      "api.spacexdata.com",
      "/v4/launches/latest",
    );

    final response = await http.get(url);
    final jsonResponse = convert.jsonDecode(response.body);

    print(jsonResponse["name"]);
    // print(jsonResponse["patch"]);
    print(jsonResponse["details"]);
    return ApiResponse.fromJson(jsonResponse);
  }

  @override
  void initState() {
    apiResponse = fetchResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Validation"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder<ApiResponse>(
            future: apiResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    children: [
                      Text(snapshot.data!.name),
                    ],
                  ),
                );
                // Exclamation mark turns nullable to non-nullable type
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
          FutureBuilder<ApiResponse>(
            future: apiResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    children: [
                      Text(snapshot.data!.details),
                    ],
                  ),
                );
                // Exclamation mark turns nullable to non-nullable type
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          print("Button is pressed");
          fetchResponse();
        },
        child: Text("Print Response"),
      ),
    );
  }
}
