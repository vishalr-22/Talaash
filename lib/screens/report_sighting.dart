import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:talaash/screens/choose_location.dart';
import 'package:talaash/utils/get_place.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum AloneStatus { yes, no, notSure }

class ReportSightingPage extends StatefulWidget {
  // const ReportSightingPage({Key? key, required this.title}) : super(key: key);
  const ReportSightingPage({Key? key, required this.title, required this.image})
      : super(key: key);
  final String title;
  final XFile image;

  @override
  State<ReportSightingPage> createState() => _ReportSightingPageState();
}

class _ReportSightingPageState extends State<ReportSightingPage> {
  AloneStatus _status = AloneStatus.yes;
  String? contact = "";
  String? address = "";
  // TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            children: <Widget>[
              Container(
                // child: Image(
                //   image: AssetImage('images/child1.jfif'),
                //   height: 150,
                // ),
                child: Image(
                  image: FileImage(File(widget.image.path)),
                  height: 150,
                ),
              ),
              Text(
                "Where did you sight him/her?",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () async {
                  final location = await Navigator.push(
                    context,
                    // Create the SelectionScreen in the next step.
                    MaterialPageRoute(
                        builder: (context) => const ChooseLocationPage()),
                  );
                  // print(location);
                  final place = await getPlace(location);
                  print(place);
                  setState(() {
                    address = place;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Pick Location", style: TextStyle(fontSize: 20)),
                    Icon(Icons.location_on),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: address == ""
                    ? Text(
                        "Location",
                        style: TextStyle(fontSize: 20),
                      )
                    : Text("$address",
                        style: TextStyle(
                          fontSize: 20,
                        )),
              ),
              Text(
                "Was he/she alone?",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    fillColor: MaterialStateProperty.all(Colors.blue),
                    value: AloneStatus.yes,
                    groupValue: _status,
                    onChanged: (AloneStatus? value) {
                      setState(() {
                        _status = value!;
                      });
                    },
                  ),
                  Text(
                    "Yes",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Radio(
                    fillColor: MaterialStateProperty.all(Colors.blue),
                    value: AloneStatus.no,
                    groupValue: _status,
                    onChanged: (AloneStatus? value) {
                      setState(() {
                        _status = value!;
                      });
                    },
                  ),
                  Text(
                    "No",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Radio(
                    fillColor: MaterialStateProperty.all(Colors.blue),
                    // activeColor: Colors.white,
                    value: AloneStatus.notSure,
                    groupValue: _status,
                    onChanged: (AloneStatus? value) {
                      setState(() {
                        _status = value!;
                      });
                    },
                  ),
                  Text(
                    "Not Sure",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Text(
                "Can you provide your contact number? (optional)",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    contact = value;
                  });
                },
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Contact Number",
                    labelText: '$contact',
                    fillColor: Colors.white),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xff209c1e)),
                  onPressed: () {
                    print('Sighting reported!');
                    if (address != "") {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MatchResolver(
                      //             address: address!,
                      //             aloneStatus: _status.toString(),
                      //             title: "Report Missing Child",
                      //             contact: contact!,
                      //             image: widget.image)));
                    }
                  },
                  child:
                      Text("Report Sighting", style: TextStyle(fontSize: 24))),
            ],
          ),
        ),
      ),
    );
  }
}
