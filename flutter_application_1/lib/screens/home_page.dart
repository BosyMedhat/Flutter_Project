import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_servies.dart';
import 'package:flutter_application_1/screens/car_type_page.dart';
import 'package:flutter_application_1/screens/chat_with_driver_page.dart';
import 'package:flutter_application_1/screens/driver_details_page.dart';
import 'package:flutter_application_1/screens/location_page.dart';
import 'package:flutter_application_1/screens/payment_page.dart';
import 'package:flutter_application_1/screens/rate_driver_page.dart';
import 'package:flutter_application_1/screens/track_car_page.dart';
import 'package:flutter_application_1/screens/trip_review_page.dart';
import 'package:flutter_application_1/widget/home_card.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  final String? username;
  const HomePage({this.username, super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome, ${AuthService().getUsername().toString()}!',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: [
                  HomeCard(
                    icon: Icons.map,
                    label: 'Location',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LocationPage()),
                      );
                    },
                  ),
                  HomeCard(
                    icon: Icons.directions_car,
                    label: 'Car Type',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CarTypePage()),
                      );
                    },
                  ),
                  HomeCard(
                    icon: Icons.reviews,
                    label: 'Trip Review',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TripReviewPage()),
                      );
                    },
                  ),
                  HomeCard(
                    icon: Icons.car_repair,
                    label: 'Track Car',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TrackCarPage()),
                      );
                    },
                  ),
                  HomeCard(
                    icon: Icons.person,
                    label: 'Driver Details',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DriverDetailsPage()),
                      );
                    },
                  ),
                  HomeCard(
                    icon: Icons.chat,
                    label: 'Chat with Driver',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ChatWithDriverPage()),
                      );
                    },
                  ),
                  HomeCard(
                    icon: Icons.payment,
                    label: 'Payment',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PaymentPage()),
                      );
                    },
                  ),
                  HomeCard(
                    icon: Icons.star,
                    label: 'Rate Driver',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RateDriverPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => SettingsPage(
                          username: widget.username ?? "User",
                          toggleLanguage: () {},
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.settings_rounded, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (_) => const SignInPage()),
                //   (route) => false,
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FFF0),
                foregroundColor: const Color(0xFF002E6D),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF00FFEE).withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout_rounded, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
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
