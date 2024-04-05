import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() => runApp(ScanPage());



class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Scan Your /.,mns Face ',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20
            ),
        ),
      ),
      home: TfliteModel(),
    );
  }
}

class TfliteModel extends StatefulWidget {
  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  File? _image;
  List? _results;
  bool imageSelect = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }


/******************************** load model ********************************/
  Future loadModel() async {
    Tflite.close();
    String? res;
    res = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 32, 33),
      appBar: AppBar(
        /********************************************Head******************************************/
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Scan Diseases',
          style: TextStyle(
          color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 22, 0, 147),
      ),


/**********************************************************  Body of the Scan   **********************************/
      body: ListView(
        children: <Widget>[
          if (imageSelect)
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Image.file(_image!),
            height: 400,
            width: MediaQuery.of(context).size.width - 200,
            )
            
            else
            Container(
              margin: const EdgeInsets.only(top: 330),
              child: const Opacity(
                opacity: 0.9,
                child: Center(
                  child: Text(
                    "No image selected",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                      ),
                  ),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: imageSelect
                  ? _results!.map((result) {
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "${result['label']} - ${(result['confidence'] as double).toStringAsFixed(2)}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList()
                  : [],
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: pickImage2,
            tooltip: "Pick Image from Gallery",
            backgroundColor: Color.fromARGB(255, 252, 254, 248),
            child: const Icon(Icons.image),
          ),
          SizedBox(width: 15.0),
          FloatingActionButton(
            onPressed: pickImage,
            tooltip: "Take a Picture",
            backgroundColor: const Color.fromARGB(255, 252, 254, 248),
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }

  Future pickImage2() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }
}

