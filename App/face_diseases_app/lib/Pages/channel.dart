
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:face_diseases_app/model/user.dart';
import 'package:flutter/material.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  List<User> _users = [];
  List<User> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _firestoreService.getUsers().listen((userList) {
      setState(() {
        _users = userList;
        _filteredUsers = _users;
      });
    });
  }

  void onSearch(String search) {
    setState(() {
      _filteredUsers = _users.where((user) =>
        user.username.toLowerCase().contains(search.toLowerCase()) ||
        user.name.toLowerCase().contains(search.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 250, 250)),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard())),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 99, 172, 143),
        title: Container(
          height: 38,
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              hintText: "Search Doctor Name or District"
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 253, 253, 253),
          /*gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 241, 169, 169),
              Color.fromARGB(255, 157, 235, 179),
              Color.fromARGB(255, 241, 169, 169),
            ],
          ),*/
        ),
        child: ListView.builder(
          itemCount: _filteredUsers.length,
          itemBuilder: (context, index) => userComponent(user: _filteredUsers[index]),
        ),
      ),
    );
  }

  Widget userComponent({required User user}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(user.image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                Text(user.username, style: const TextStyle(color: Color.fromARGB(255, 81, 80, 80))),
              ],
            ),
          ]),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(user.name),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hospital: ${user.username}"),
                    Text("Information: ${user.info}"),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),

          child: AnimatedContainer(
              duration: const Duration(milliseconds:300),
              height: 35,
              width: 110,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 99, 172, 143),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.transparent),
              ),
              child: const Center(
                child: Text('Info', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<User>> getUsers() {
    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }
}
