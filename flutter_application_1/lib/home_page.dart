import 'package:flutter/material.dart';
import 'car_type_page.dart';
import 'trip_review_page.dart';
import 'track_car_page.dart';
import 'driver_details_page.dart';
import 'chat_with_driver_page.dart';
import 'payment_page.dart';
import 'rate_driver_page.dart';
import 'SignInPage.dart';
import 'settings_page.dart';
import 'location_page.dart';  // استيراد صفحة الموقع

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({required this.username, super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isArabic = false;

  void toggleLanguage() {
    setState(() {
      isArabic = !isArabic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'VOYAA 🚗',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE0E0E0), // فضي لامع
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isArabic ? 'مرحباً، ${widget.username}!' : 'Welcome, ${widget.username}!',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildFeatureCard(context, Icons.map, isArabic ? 'الموقع' : 'Location', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LocationPage()), // تفعيل الزر للانتقال إلى صفحة الموقع
                      );
                    }),
                    _buildFeatureCard(
                      context,
                      Icons.directions_car,
                      isArabic ? 'نوع السيارة' : 'Car Type',
                          () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CarTypePage())),
                    ),
                    _buildFeatureCard(
                      context,
                      Icons.reviews,
                      isArabic ? 'مراجعة الرحلة' : 'Trip Review',
                          () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => TripReviewPage())),
                    ),
                    _buildFeatureCard(
                      context,
                      Icons.car_repair,
                      isArabic ? 'تتبع السيارة' : 'Track Car',
                          () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => TrackCarPage())),
                    ),
                    _buildFeatureCard(
                      context,
                      Icons.person,
                      isArabic ? 'تفاصيل السائق' : 'Driver Details',
                          () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DriverDetailsPage())),
                    ),
                    _buildFeatureCard(
                      context,
                      Icons.chat,
                      isArabic ? 'الدردشة مع السائق' : 'Chat with Driver',
                          () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ChatWithDriverPage())),
                    ),
                    _buildFeatureCard(
                      context,
                      Icons.payment,
                      isArabic ? 'الدفع' : 'Payment',
                          () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PaymentPage())),
                    ),
                    _buildFeatureCard(
                      context,
                      Icons.star,
                      isArabic ? 'تقييم السائق' : 'Rate Driver',
                          () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RateDriverPage())),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // زر الإعدادات
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsPage(
                        username: widget.username,
                        toggleLanguage: toggleLanguage,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.settings),
                label: Text(isArabic ? 'الإعدادات' : 'Settings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInPage()),
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.exit_to_app),
                label: Text(isArabic ? 'تسجيل الخروج' : 'Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFF0),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context,
      IconData icon,
      String label,
      Function() onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white.withOpacity(0.1),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF00FFF0)),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
