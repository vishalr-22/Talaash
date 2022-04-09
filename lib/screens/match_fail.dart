import 'package:flutter/material.dart';
import 'package:talaash/screens/report_sighting.dart';
import 'package:talaash/utils/pick_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class MatchFailPage extends StatefulWidget {
  const MatchFailPage({Key? key, required this.title, required this.image})
      : super(key: key);
  final String title;
  final XFile? image;

  @override
  State<MatchFailPage> createState() => _MatchFailPageState();
}

class _MatchFailPageState extends State<MatchFailPage> {
  @override
  XFile? newImage;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "NO MATCH FOUND",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: Image(
                  image: AssetImage('images/child1.jfif'),
                  height: 300,
                ),
                // child: Image(
                //   image: FileImage(File(image!.path)),
                //   height: 300,
                //   width: 400,
                // ),
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        XFile? tmp = await pickImage(ImageSource.camera);
                        print(tmp);
                        setState(() {
                          newImage = tmp;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportSightingPage(
                                    title: "Report Missing Child",
                                    image: newImage!)));
                      },
                      child:
                          Text("Take Photo", style: TextStyle(fontSize: 20))),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "OR",
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        XFile? tmp = await pickImage(ImageSource.gallery);
                        print(tmp);
                        setState(() {
                          newImage = tmp;
                        });
                      },
                      child: Text("Upload", style: TextStyle(fontSize: 20))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
