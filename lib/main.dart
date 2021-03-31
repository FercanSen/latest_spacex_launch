import 'dart:convert' as convert;

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  fetchAlbum() async {
    final url = Uri.https(
      "api.spacexdata.com",
      "/v4/launches/latest",
      // {'q': '{http}'},
    );

    final response = await http.get(url);
    final jsonResponse = convert.jsonDecode(response.body);

    print(jsonResponse["name"]);
    print(jsonResponse["patch"]);
    print(jsonResponse["details"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Validation"),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                fetchAlbum();
              },
              child: Text("Print Response"),
            ),
          ),
        ],
      ),
    );
  }
}
