import 'package:flutter/material.dart';

class LaptopDetailsPage extends StatelessWidget {
  final Map<String, dynamic> laptopDetails;
  final String imagePath;

  LaptopDetailsPage({required this.laptopDetails, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laptop Details',
          style: TextStyle(color: Colors.white),
        ),
        toolbarHeight: 75,
        backgroundColor: Colors.indigo[800],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${laptopDetails['name']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Price: Rs. ${laptopDetails['price']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Processor: ${laptopDetails['processor']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'RAM: ${laptopDetails['ram']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Storage: ${laptopDetails['storage']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Display: ${laptopDetails['display']}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
