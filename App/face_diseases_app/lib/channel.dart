import 'package:face_diseases_app/model/user.dart';
import 'package:flutter/material.dart';

class ChannelPage extends StatelessWidget{

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


/*******************************Add Doctors And Hospitals***********************************/
class _HomePageState extends State<HomePage> {
  List<User> _users = [
    User(
        'DR(MRS) P. SENAKA',
        'Hambantota Hospital',
        
        'https://i1.rgstatic.net/ii/profile.image/751258864480260-1556125479393_Q512/Indira-Kahawita.jpg',
        'hi my name is doctor i works general hsoptilat',
        false
        ),
    User(
        'DR S. ABEYKEERTHI',
        'Anuradhapura Hospital',
        
        'https://groundviews.org/wp-content/uploads/2012/08/Screen-Shot-2012-08-27-at-11.37.32-PM.jpg',
        'hi my name is doctor i works general hsoptilat',
        false
        ),

    User(
        'DR UWAYSE AHAMED',
        'Colombo Hospital',
 
        'https://www.happysrilankans.com/wp-content/uploads/2020/11/Dr.-Uvais-Ahamed.jpg',
        'hi my name is doctor i works general hsoptilat',
        false
        ),
    User(
        'DR JANAKA AKARAWITA',
        'Colombo Hospital',
         
        'https://s3-us-west-1.amazonaws.com/co-directory-images/janaka-akarawita-6bb12843.jpg',
        'hi my name is doctor i works general hsoptilat',
        false
        ),
    User(
        'DR P. AKURUGODA',
        'Galle Hospital',
       
        'https://ochrehealth.com.au/wp-content/uploads/2020/08/Dr-Chameera-Akurugoda-400x400.jpeg',
        'hi my name is doctor i works general hsoptilat',
        false
        ),
    User('DR D.M AMARATHUNGA',
        'Matara Hospital',
     
        'https://docplayer.net/docs-images/90/101512065/images/5-4.jpg',
        'hi my name is doctor i works general hsoptilat',
        false
        ),
    User('DR D. ARIYAWANSA',
          'Ambalantoa Hospital',
  
        'https://i.ytimg.com/vi/IZYZJfqdvq8/maxresdefault.jpg',
        'hi my name is doctor i works general hsoptilat',false
        ),
    User(
        'DR G. ARSECULERATNE',
        'Gampaha Hospital',
        
        'https://bmkltsly13vb.compat.objectstorage.ap-mumbai-1.oraclecloud.com/cdn.ft.lk/assets/uploads/image_dcdad01ce0.jpg',
        'hi my name is doctor i works general hsoptilat',false
        ),
    User(
        'DR D. BANDARA',
        'Mathale Hospital',
     
        'https://umanitoba.ca/agricultural-food-sciences/sites/agricultural-food-sciences/files/styles/3x2_900w/public/2021-02/fhns-nandika-bandara.jpg',
        'hi my name is doctor i works general hsoptilat',false
        ),
    User(
        'DR MAHINDA DE SILVA',
        'Gampaha Hospital',
     
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        'hi my name is doctor i works general hsoptilat',false
        ),
    User(
        'DR UPENDRA DE SILVA',
        'Gampaha  Hospital',
         
        'https://images.unsplash.com/photo-1542534759-05f6c34a9e63?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        'hi my name is doctor i works general hsoptilat',false
        ),
    User(
        'DR MANEL DISSANAYAKE',
        'Nugegoda  Hospital',
 
        'https://images.unsplash.com/photo-1516239482977-b550ba7253f2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        
        'hi my name is doctor i works general hsoptilat',false
        ),
    User(
        'DR D.M.S DISSANAYAKE',
        'Matara  Hospital',
      
        'https://images.unsplash.com/photo-1542973748-658653fb3d12?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        'hi my name is doctor i works general hsoptilat',false
        ),
    User(
        'DR S. EKANAYAKA',
        'Galle Hospital',
     
        'https://images.unsplash.com/photo-1569443693539-175ea9f007e8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        'hi my name is doctor i works general hsoptilat',false
        ),
    User(
        'DR(MRS) S FELECIA',
        'Karapitiya Hospital',
   
        'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
        'hi my name is doctor i works general hsoptilat',false
        ),
  ];

  List<User> _foundedUsers = [];

  @override
  void initState() {
    
    super.initState();

    setState(() {
      _foundedUsers = _users;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedUsers = _users
          .where((user) => user.username.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 22, 0, 147),
        title: Container(
          height: 38,
          child: TextField(
            onChanged: (value) => onSearch(value),
            decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Search Docter Name or District"),
          ),
        ),
      ),


      /*************************************************Body of channel*******************************************/
      body: Container(
        decoration: BoxDecoration(
                  gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 241, 169, 169),
                Color.fromARGB(255, 157, 235, 179),
                Color.fromARGB(255, 241, 169, 169),
              ],
              
            ),
            ),
        //color: Color.fromARGB(255, 255, 239, 254),
        child: _foundedUsers.length > 0
            ? ListView.builder(
                itemCount: _foundedUsers.length,
                itemBuilder: (context, index) {
                  return userComponent(user: _foundedUsers[index]);
                })
            : Center(
                child: Text(
                "No users found",
                style: TextStyle(color: Colors.black),
              )),
      ),
    );
  }

  userComponent({required User user})
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(user.image),
                )),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(user.name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 5,
              ),
              Text(user.username, style: TextStyle(color: Color.fromARGB(255, 81, 80, 80))),
            ])
          ]),


          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    height: 200, // Adjust the height as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          //'Doctors Details',
                          ' ${user.name}',
                          style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        Text('Doctor Name: ${user.name}'),
                        Text('Hospital: ${user.username}'),
                        // Text('Contact Number: ${user.contact}'),
                        //Text('Followers: ${user.followersCount}'),
                        Text('Infomation: ${user.info}'),
                        ],
                      ),
                    );
                  },
                );
              },
              child: AnimatedContainer(
                height: 35,
                width: 110,
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                color: user.isFollowedByMe ? Color.fromARGB(255, 66, 58, 151) : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                color: user.isFollowedByMe ? Colors.transparent : Colors.black45,
                ),
              ),
              child: Center(
                child: Text(
                  'Info',
                  style: TextStyle(
                    color: user.isFollowedByMe ? Color.fromARGB(255, 62, 75, 177) : Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
