import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Method

const wave = SpinKitWave(
  color: Colors.green,
  size: 50.0,
);

class MatchResolver extends StatefulWidget {
  final String title;
  // final XFile image;
  XFile? image;
  final String aloneStatus;
  final String address;
  final String contact;

  MatchResolver(
      {Key? key,
      required this.title,
      this.image,
      required this.aloneStatus,
      required this.address,
      required this.contact})
      : super(key: key);

  @override
  State<MatchResolver> createState() => _MatchResolverState();
}

class _MatchResolverState extends State<MatchResolver> {
  Future<http.Response> postRequest() async {
    var baseUrl = 'http://10.0.2.2:5000';
    List<int> imageBytes = File(widget.image!.path).readAsBytesSync();

    String imageB64 = base64Encode(imageBytes);
    Map data = {
      'image': imageB64,
      'aloneStatus': widget.aloneStatus,
      'address': widget.address,
      'contact': widget.contact
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse('$baseUrl/report_sighting'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: body);
    // print("${response.statusCode}");
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to make a request');
    }
  }

  @override
  void initState() {
    super.initState();

    postRequest().then((response) {
      print("result: ${response.statusCode}");
      // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffbb500),
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          height: double.infinity,
          width: double.infinity,
          color: Color(0xff353535),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[wave],
          ),
        ),
      ),
    );
  }
}
