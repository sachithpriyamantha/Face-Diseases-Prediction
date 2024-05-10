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
  "acne": "A condition characterized by red pimples on the skin, especially on the face, due to inflamed or infected sebaceous glands. \n\n"
          "1. Cleanse Gently: Use a mild, non-comedogenic cleanser to wash your face twice a day. Avoid scrubbing your face harshly, as this can irritate the skin and worsen acne.\n\n"
          "2. Use Appropriate Products: Look for skincare products that are labeled as 'oil-free' or 'non-comedogenic,' which means they won't clog pores. Products containing ingredients like salicylic acid or benzoyl peroxide can be beneficial.\n\n"
          "3. Moisturize: Even if your skin is oily, it's important to keep it hydrated with an oil-free moisturizer. Dry skin can trigger more oil production, leading to more breakouts.\n\n"
          "4. Avoid Touching Your Face: Keep your hands away from your face to prevent the transfer of oils and bacteria that can cause acne.\n\n"
          "5. Watch Your Diet: Some people find that certain foods, especially those high in dairy and sugar, can trigger acne. Keeping a food diary may help you identify and avoid these triggers.\n\n"
          "6. Manage Stress: High stress levels can increase the hormone cortisol, exacerbating acne. Try stress-reduction techniques such as yoga, meditation, or deep breathing.\n\n"
          "7. Protect Your Skin: Use sunscreen designed for the face with at least SPF 30. Sun exposure can damage your skin and lead to more acne flare-ups.",
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


  recognitions?.forEach((result) {
    String rawLabel = result['label'];
    String normalizedLabel = rawLabel.toLowerCase().trim();
    String description = diseaseDescriptions[normalizedLabel] ?? "No description available";
    print("Label: $rawLabel, Normalized: $normalizedLabel, Description: $description");
  });


  print("Testing mapping with 'acne': ${diseaseDescriptions['acne']}");
  print("Testing mapping with 'normal': ${diseaseDescriptions['normal']}");

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
      backgroundColor: Color.fromARGB(255, 99, 172, 143),
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
                  String rawLabel = result['label'];
                  String label = rawLabel.toLowerCase().trim();
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
                          Container(
  //color: Color.fromARGB(255, 156, 189, 105),
  padding: const EdgeInsets.all(8),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(16.0), // Adjust the radius value to your preference
    child: Container(
      color: Color.fromARGB(255, 156, 189, 105), // Color of the inner container
      padding: const EdgeInsets.all(10),
      child: Text(
        description,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
    ),
  ),
),

                        ],
                      ),
                    ),
                  );
                }).toList()
              : [Text("Waiting for results...")],
          ),
        )
      ],
    ),

    floatingActionButton: Padding(
  padding: const EdgeInsets.only(bottom: 50),
  child: Row(
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



