import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptopstore/DellLaptop.dart';
import 'package:laptopstore/LenovoLaptop.dart';
import 'package:laptopstore/AppleLaptop.dart';
import 'package:laptopstore/HpLaptop.dart';
import 'package:laptopstore/Others.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageUrls = [
    'assets/images/laptopad1.png',
    'assets/images/laptopad2.jpg',
    'assets/images/laptopad3a.png',
  ];

  late PageController _pageController;
  int _currentPageIndex = 0;

  User? user;
  String username = 'User'; // Default to 'User' if the username is not fetched
  bool isLoading = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);

    // Auto slide images every 5 seconds
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPageIndex < imageUrls.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });

    // Fetch the current user
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            username = documentSnapshot['username'] ?? 'User';
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        print("Failed to fetch user data: $error");
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/LaptopStoreLogo.png',
                  height: 80,
                ),
                SizedBox(
                  width: 8,
                ), // Add some spacing between the image and title
                Text(
                  'Laptop Store',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.indigo[800],
            toolbarHeight: 75,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.indigo[800],
                  ),
                  child: isLoading
                      ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/images/LaptopStoreLogo.png',
                            height: 65,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 40,
                    height: 30,
                    child: Image.asset('assets/images/homelogo.png'),
                  ),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/hplogo.png'),
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
                  leading: SizedBox(
                    width: 40,
                    height: 30,
                    child: Image.asset('assets/images/Delllogo.png'),
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
                  leading: SizedBox(
                    width: 39,
                    height: 38,
                    child: Image.asset('assets/images/Lenovologo2.png'),
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
                  leading: SizedBox(
                    width: 40,
                    height: 30,
                    child: Image.asset('assets/images/applelogo.png'),
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
                  leading: SizedBox(
                    width: 40,
                    height: 30,
                    child: Image.asset('assets/images/otherslogo.png'),
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
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),

                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Welcome to Laptop Store!',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 1.0,
                                      color: Colors.grey,
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16),

                      //Images ads
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: SizedBox(
                          height: 200,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: imageUrls.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPageIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Image.asset(
                                imageUrls[index % imageUrls.length],
                                height: 200,
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        'Products:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 5.0,
                  children: [
                    // HP Laptop Card
                    buildLaptopCard(
                      context,
                      'assets/images/hplogo.png',
                      'HP Laptop',
                      HpLaptop(),
                    ),
                    // Dell Laptop Card
                    buildLaptopCard(
                      context,
                      'assets/images/delllogo1.png',
                      'Dell Laptop',
                      DellLaptop(),
                    ),
                    // Lenovo Laptop Card
                    buildLaptopCard(
                      context,
                      'assets/images/Lenovologo1.png',
                      'Lenovo Laptop',
                      LenovoLaptop(),
                    ),
                    // Apple Laptop Card
                    buildLaptopCard(
                      context,
                      'assets/images/applelogo.png',
                      'Apple Laptop',
                      AppleLaptop(),
                    ),
                    // Others Card
                    buildLaptopCard(
                      context,
                      'assets/images/otherslogo.png',
                      'Others',
                      Others(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget buildLaptopCard(BuildContext context, String imagePath,
      String laptopName, Widget targetPage) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff121660), Color(0xff0171df)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Card(
        color: Colors.transparent,
        child: SizedBox(
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 72,
                padding: EdgeInsets.all(5.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  laptopName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => targetPage),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'See Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show logout confirmation dialog
  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to handle logout
  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print("Error logging out: $e");
      // Handle error
    }
  }
}