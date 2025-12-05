import 'package:flutter/material.dart';

class DriverDetailsPage extends StatelessWidget {
  const DriverDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF00FFF0)),
        title: const Text(
          'Driver Details',
          style: TextStyle(color: Color(0xFF00FFF0)),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF002E6D), // أزرق داكن جدًا
              Color(0xFF006F9E), // أزرق متألق
              Color(0xFF3A7BB9), // أزرق لامع
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 1.0],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF00FFF0),
                child: Icon(Icons.person, size: 50, color: Colors.black),
              ),
              const SizedBox(height: 30),
              _buildInfoCard(Icons.person, 'Name', 'Ahmed Ali'),
              _buildInfoCard(Icons.directions_car, 'Car', 'Toyota Camry 2022'),
              _buildInfoCard(Icons.confirmation_number, 'Plate', 'XYZ 1234'),
              _buildInfoCard(Icons.phone, 'Phone', '+201234567890'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String detail) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00FFF0)),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          detail,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
