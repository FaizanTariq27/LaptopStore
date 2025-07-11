import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'laptop_details_page.dart';
import 'package:laptopstore/HomePage.dart';
import 'package:laptopstore/AppleLaptop.dart';
import 'package:laptopstore/HpLaptop.dart';
import 'package:laptopstore/LenovoLaptop.dart';
import 'package:laptopstore/Others.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:laptopstore/DellLaptop.dart';

class DellLaptop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dell Laptops',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        toolbarHeight: 75,
        backgroundColor: Colors.indigo[800], // Set app bar background color to indigo
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('No user data found'));
            }

            Map<String, dynamic> userData =
            snapshot.data!.data() as Map<String, dynamic>;
            String username = userData['username'] ?? 'Unknown';

            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.indigo[800],
                  ),
                  child: Text(
                    username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/homelogo.png',
                    width: 40,
                    height: 30,
                  ),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/hplogo.png',
                    width: 40,
                    height: 40,
                  ),
                  title: Text('HP'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HpLaptop()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/Delllogo.png',
                    width: 40,
                    height: 30,
                  ),
                  title: Text('Dell'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DellLaptop()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/Lenovologo2.png',
                    width: 39,
                    height: 38,
                  ),
                  title: Text('Lenovo'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LenovoLaptop()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/applelogo.png',
                    width: 40,
                    height: 30,
                  ),
                  title: Text('Apple'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AppleLaptop()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/images/otherslogo.png',
                    width: 40,
                    height: 30,
                  ),
                  title: Text('Others'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Others()),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: Container(
        color: Colors.white, // Set page background color to white
        child: GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.70, // Adjust the aspect ratio as needed
          ),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Laptops')
                  .doc('Dell')
                  .collection('delllaptop')
                  .doc('laptop${index + 1}')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(
                    child: Text('No data available'),
                  );
                }

                Map<String, dynamic> laptopData = snapshot.data!.data() as Map<String, dynamic>;
                String name = laptopData['name'] ?? 'Unknown';
                int price = laptopData['price'] ?? 0; // Assuming price is of type int
                String imagePath = '';
                String url = laptopData['url'] ?? '';

                // Assigning image path based on laptop index
                switch (index) {
                  case 0:
                    imagePath = 'assets/images/dellg16.jpg';
                    break;
                  case 1:
                    imagePath = 'assets/images/delllatitude3540.jpg';
                    break;
                  case 2:
                    imagePath = 'assets/images/dellvostro.jpg';
                    break;
                  case 3:
                    imagePath = 'assets/images/delllatitude7390.jpg';
                    break;
                  case 4:
                    imagePath = 'assets/images/asus tuf.jpg';
                    break;
                  case 5:
                    imagePath = 'assets/images/asusrog.jpg';
                    break;
                  case 6:
                    imagePath = 'assets/images/asusrog.jpg';
                    break;
                  case 7:
                    imagePath = 'assets/images/dellvostro.jpg';
                    break;
                  case 8:
                    imagePath = 'assets/images/delllatitude3540.jpg';
                    break;
                  case 9:
                    imagePath = 'assets/images/aceraspire5.jpg';
                    break;
                  default:
                    imagePath = 'assets/images/LaptopStoreLogo.png'; // Default image path
                    break;
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LaptopDetailsPage(
                          laptopDetails: laptopData,
                          imagePath: imagePath, // Pass imagePath here
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo[800],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            height: 90.0,
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 3.0),
                                Text(
                                  'Price: Rs. $price',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 3.0),
                                ElevatedButton(
                                  onPressed: () {
                                    _launchURL(url);
                                  },
                                  child: Text(
                                    'Buy Now',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Function to launch URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
