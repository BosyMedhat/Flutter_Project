import 'package:flutter/material.dart';

class TrackCarPage extends StatelessWidget {
  const TrackCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Car',
          style: TextStyle(color: Color(0xFF00FFF0)), // لون النص أزرق فاتح
        ),
        backgroundColor: Colors.transparent, // خلفية شفافة
        iconTheme: IconThemeData(color: Color(0xFF00FFF0)), // لون الأيقونة
        elevation: 0, // إزالة الظل
      ),
      extendBodyBehindAppBar: true, // جعل الخلفية تتداخل مع AppBar
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 100,
                color: Color(0xFF00FFF0), // اللون الأزرق الفاتح للأيقونة
              ),
              SizedBox(height: 20),
              Text(
                'Tracking your car...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                color: Color(0xFF00FFF0), // اللون الأزرق الفاتح لمؤشر التحميل
              ),
              SizedBox(height: 40),
              Text(
                'Estimated Arrival Time: 5 mins',
                style: TextStyle(
                  color: Color(0xFF00FFF0), // اللون الأزرق الفاتح
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
