/*import 'dart:io';

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

*/
/*
import 'dart:io';

import 'package:face_diseases_app/Pages/dashboard.dart';
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
      title: 'Scan Your Face',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
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

  // Map to store disease labels and descriptions
  Map<String, String> diseaseDescriptions = {
    "label1": "Description of Disease 1",
    "label2": "Description of Disease 2",
    // Add more disease labels and descriptions as needed
  };

  @override
  void initState() {
    super.initState();
    loadModel();
  }

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
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
        title: Text(
          'Scan Diseases',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 22, 0, 147),
      ),
      body: ListView(
        children: <Widget>[
          if (imageSelect)
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width - 20,
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
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: imageSelect
                  ? _results!.map((result) {
                      String label = result['label'];
                      double confidence = result['confidence'] * 100;
                      String description =
                          diseaseDescriptions['label'] ?? "No description available";
                      return Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$label - ${confidence.toStringAsFixed(2)}%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                description,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
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
*/


/*
import 'dart:io';

import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';


void main() => runApp(const ScanPage());

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scan Your Face',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      home: const TfliteModel(),
    );
  }
}

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  File? _image;
  List? _results;
  bool imageSelect = false;

  Map<String, String> diseaseDescriptions = {
    "acne": "A condition characterized by red pimples on the skin, especially on the face, due to inflamed or infected sebaceous glands.",
    "atopic dermatitis": "An inflammatory skin disease known as eczema, which is characterized by itchy, red, swollen, and cracked skin patches.",
    "eczema": "A medical condition that causes the skin to become itchy, dry, cracked, sore, and red.",
    "seborrheic keratoses": "A common skin growth that looks like a wart, typically appears as brown, black or light tan spots on the face, chest, shoulders or back.",
    "tinea ringworm": "A fungal infection that causes a red, itchy, scaly circular rash on the body.",
    "normal": "No skin disease detected. Skin appears to be normal."
  };

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String? res;
    res = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    print("Model loading status: $res");
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
      _results = recognitions;
      _image = image;
      imageSelect = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 32, 33),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
        title: const Text('Scan Diseases', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 22, 0, 147),
      ),
      body: ListView(
        children: <Widget>[
          if (imageSelect && _image != null)
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(_image!, fit: BoxFit.cover),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width - 20,
            ),
          if (!imageSelect)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 300),
                child: Text(
                  "No image selected",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: imageSelect && _results != null
                  ? _results!.map<Widget>((result) {
                      String label = result['label'].toLowerCase(); // Normalize the label
                      double confidence = result['confidence'] * 100;
                      String description = diseaseDescriptions[label] ?? "No description available";
                      return Card(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$label - ${confidence.toStringAsFixed(2)}%",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                description,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
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
            backgroundColor: const Color.fromARGB(255, 252, 254, 248),
            child: const Icon(Icons.image),
          ),
          const SizedBox(width: 15),
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
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }

  Future pickImage2() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }
}
*/



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ScanPage());
}

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scan Your Face',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      home: const TfliteModel(),
    );
  }
}

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  File? _image;
  List? _results;
  bool imageSelect = false;

  Map<String, String> diseaseDescriptions = {
    "acne": "A condition characterized by red pimples on the skin, especially on the face, due to inflamed or infected sebaceous glands.",
    "atopic dermatitis": "An inflammatory skin disease known as eczema, which is characterized by itchy, red, swollen, and cracked skin patches.",
    "eczema": "A medical condition that causes the skin to become itchy, dry, cracked, sore, and red.",
    "seborrheic keratoses": "A common skin growth that looks like a wart, typically appears as brown, black or light tan spots on the face, chest, shoulders or back.",
    "tinea ringworm": "A fungal infection that causes a red, itchy, scaly circular rash on the body.",
    "normal": "No skin disease detected. Skin appears to be normal."
  };

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String? res = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    print("Model loading status: $res");
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
      _results = recognitions;
      _image = image;
      imageSelect = true;
    });
    saveResultsToFirebase(recognitions);
  }

  Future<void> saveResultsToFirebase(List<dynamic>? recognitions) async {
    if (recognitions != null && recognitions.isNotEmpty) {
      final docUser = FirebaseFirestore.instance.collection('disease_reports').doc();
      await docUser.set({
        'date': DateTime.now().toIso8601String(),
        'results': recognitions.map((result) => {
          'label': result['label'],
          'confidence': result['confidence']
        }).toList(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 32, 33),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          ),
        ),
        title: const Text('Scan Diseases', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 22, 0, 147),
      ),
      body: ListView(
        children: <Widget>[
          if (imageSelect && _image != null)
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(_image!, fit: BoxFit.cover),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width - 20,
            ),
          if (!imageSelect)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 300),
                child: Text(
                  "No image selected",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: imageSelect && _results != null
                  ? _results!.map<Widget>((result) {
                      String labels = result['label'].toLowerCase(); // Normalize the label
                      double confidence = result['confidence'] * 100;
                      String description = diseaseDescriptions[labels] ?? "No description available";
                      return Card(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$labels - ${confidence.toStringAsFixed(2)}%",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                description,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            ],
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
            backgroundColor: const Color.fromARGB(255, 252, 254, 248),
            child: const Icon(Icons.image),
          ),
          const SizedBox(width: 15),
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
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }

  Future pickImage2() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      imageClassification(image);
    }
  }
}
