import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:talaash/utils/pick_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class ChildDetailsPage extends StatefulWidget {
  // const ChildDetailsPage({Key? key, required this.title}) : super(key: key);
  const ChildDetailsPage({Key? key, required this.title, required this.image})
      : super(key: key);
  final String title;
  final XFile image;

  @override
  State<ChildDetailsPage> createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {
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
                "DETAILS",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/child1.jfif'),
                  radius: 60,
                ),
                // child: Image(
                //   image: FileImage(File(image!.path)),
                //   height: 300,
                //   width: 400,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTile(
                      title: "Name",
                      value: "Deepak Kumar",
                    ),
                    CustomTile(
                      title: "Age",
                      value: '10',
                    ),
                    CustomTile(
                      title: "Gender",
                      value: "M",
                    ),
                    CustomTile(
                      title: "Date",
                      value: "11 March 2022",
                    ),
                    CustomTile(title: "Missing from", value: "Mumbai"),
                  ],
                ),
              ),
              Text(
                "Concerned Authorities have been alerted",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Text("Take another Photo",
                        style: TextStyle(fontSize: 24)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title: ",
            style: TextStyle(
                color: Color(0xff6af100),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2)),
        Text("$value",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2)),
      ],
    );
  }
}
