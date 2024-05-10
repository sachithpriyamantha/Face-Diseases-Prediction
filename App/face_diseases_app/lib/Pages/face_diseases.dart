
import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:flutter/material.dart';

class FaceDiseasesPage extends StatelessWidget {
  const FaceDiseasesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListViewPage(),
    );
  }
}

class ListViewPage extends StatefulWidget {
  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  var titleList = [
    "Acne",
    "Atopic dermatitis",
    "Eczema",
    "Seborrheic Keratoses",
    "Tinea Ringworms"
  ];

  // Description List Here
  var descList = [
    "Acne is a common skin condition that occurs when hair follicles become clogged with oil and dead skin cells."
        " It often manifests as pimples, blackheads, whiteheads, and sometimes deeper lumps called cysts or nodules."
        "Acne can affect various parts of the body, but it is most commonly seen on the face, neck, chest, back, and shoulders.\n \n Symptom :- Small, red, and raised bumps on the skin are a hallmark of acne."
        "Pimples can have a white or black center, depending on whether the follicle is open or closed.",
    /*2*/ "Atopic dermatitis, commonly known as eczema, is a chronic inflammatory skin condition characterized by red, itchy,"
        " and inflamed skin. It often occurs in individuals with a personal or family history of allergic conditions, such as asthma"
        "or hay fever. Atopic dermatitis is not contagious and can vary in severity, with symptoms ranging from mild to"
        "severe. \n \n Symptom :- Intense itching is a characteristic symptom of atopic dermatitis. The urge to scratch can be overwhelming and may worsen the condition.",
    /*3*/ "Eczema is a general term used to describe a group of chronic skin conditions characterized by inflammation,"
        "itching, and redness. The most common type of eczema is atopic dermatitis, but the term is often used interchangeably"
        "with this specific form. Eczema can affect people of all ages, and its exact cause is not fully understood, but it"
        "is believed to involve a combination of genetic and environmental factors. \n \n Symptoms :- Intense itching is a hallmark symptom of eczema."
        "It can be so severe that it leads to persistent scratching, which in turn can exacerbate the condition.",
    /*4*/ "Seborrheic keratoses are non-cancerous, benign skin growths that commonly appear in middle-aged or older adults."
        "These growths are generally harmless and are not associated with an increased risk of skin cancer. Seborrheic keratoses can vary in color,"
        "size, and appearance, but they typically have a waxy, scaly, or 'pasted-on' appearance."
        "\n \n Symptoms :- Seborrheic keratoses are generally asymptomatic, meaning they do not cause specific symptoms such as pain or itching for most individuals",
    /*5*/ "Tinea, commonly known as ringworm, refers to a group of fungal infections that can affect the skin, nails, and scalp. Despite its name,"
        "ringworm is not caused by a worm but by various species of fungi called dermatophytes. The infection is highly contagious and can be transmitted"
        "through direct skin-to-skin contact with an infected person or by touching contaminated objects or surfaces.\n \n Symptom :- Red, scaly patches onz"
        "the skin that often form a distinct circular or ring-shaped pattern. The edges of the rash may be raised and inflamed."
  ];

  // Image Name List Here
  var imgList = [
    "assets/acne.jpg",
    "assets/Atopic.jpg",
    "assets/Eczema.jpg",
    "assets/Seborrheic.jpg",
    "assets/Tinea.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get Device Width
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      backgroundColor: Colors.transparent,
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
          'Face Diseases',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 99, 172, 143),
      ),

      /**********************************************Body*************************************************/
      body: ListView.builder(
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
          
              showDialogFunc(
                  context, imgList[index], titleList[index], descList[index]);
            },
          
            child: Card(
              color: Color.fromARGB(255, 214, 221, 234),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 110,
                    color: Color.fromARGB(255, 214, 221, 234),
                    child: Image.asset(imgList[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          titleList[index],
                          style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(168, 255, 6, 6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: width,
                          child: Text(
                            descList[index],
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 21, 21, 21)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
void showDialogFunc(BuildContext context, String img, String title, String desc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(img, width: 200, height: 200, errorBuilder: (context, error, stackTrace) => Icon(Icons.error)),
                SizedBox(height: 10),
                Text(desc),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
