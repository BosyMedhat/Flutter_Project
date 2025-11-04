import 'package:flutter/material.dart';

class CarTypePage extends StatelessWidget {
  final List<Map<String, dynamic>> carTypes = [
    {'name': 'Sedan', 'icon': Icons.directions_car},
    {'name': 'SUV', 'icon': Icons.directions_car_filled},
    {'name': 'Van', 'icon': Icons.airport_shuttle},
    {'name': 'Electric', 'icon': Icons.electric_car},
    {'name': 'Luxury', 'icon': Icons.star},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Type', style: TextStyle(color: Colors.white)),
 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Your Car Type:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: carTypes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          leading: Icon(carTypes[index]['icon'],
                              color: const Color(0xFFE0E0E0), size: 32),
                          title: Text(
                            carTypes[index]['name'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              color: Colors.white54, size: 18),
                          onTap: () {
                            // مجرد UI، مفيش actions
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}
