import 'package:flutter/material.dart';

class TripReviewPage extends StatelessWidget {
  const TripReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Review',
          style: TextStyle(color: Color(0xFF00FFF0)), // لون النص أزرق فاتح
        ),
        backgroundColor: Colors.transparent, // خلفية شفافة
        iconTheme: IconThemeData(color: Color(0xFF00FFF0)), // لون الأيقونة
        elevation: 0, // إزالة الظل
      ),
      extendBodyBehindAppBar: true, // لجعل الخلفية تتداخل مع AppBar
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
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Text(
                'Your Trip Details:',
                style: TextStyle(
                  color: Color(0xFF00FFF0),
                  fontSize: 24,
                ), // اللون الأزرق الفاتح
              ),
              SizedBox(height: 20),
              _buildTripDetail('Pickup Location', '123 Main Street'),
              _buildTripDetail('Dropoff Location', '456 Elm Street'),
              _buildTripDetail('Date', '2025-05-01'),
              _buildTripDetail('Time', '10:30 AM'),
              _buildTripDetail('Driver', 'Ahmed Ali'),
              _buildTripDetail('Car Type', 'Sedan'),
              _buildTripDetail('Fare', '\$15.00'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripDetail(String title, String value) {
    return Card(
      color: Color(0xFF2C2A44), // خلفية داكنة للمربع
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF00FFF0),
            fontSize: 18,
          ), // اللون الأزرق الفاتح
        ),
        subtitle: Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        leading: Icon(
          Icons.info_outline,
          color: Color(0xFF00FFF0),
        ), // اللون الأزرق الفاتح للأيقونة
      ),
    );
  }
}
