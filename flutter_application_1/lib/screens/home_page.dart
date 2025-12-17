import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_servies.dart';
import 'package:flutter_application_1/auth/shered_pref.dart';
import 'package:flutter_application_1/screens/car_type_page.dart';
import 'package:flutter_application_1/screens/chat_with_driver_page.dart';
import 'package:flutter_application_1/screens/driver_details_page.dart';
import 'package:flutter_application_1/screens/location_page.dart';
import 'package:flutter_application_1/screens/payment_page.dart';
import 'package:flutter_application_1/screens/rate_driver_page.dart';
import 'package:flutter_application_1/screens/track_car_page.dart';
import 'package:flutter_application_1/screens/trip_review_page.dart';
import 'package:flutter_application_1/widget/home_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = 'User';

  @override
  void initState() {
    super.initState();
    fetchName();
  }

  void fetchName() async {
    final cachedName = await SharedPrefsHelper.getUsername();
    if (mounted && cachedName != null) {
      setState(() {
        username = cachedName;
      });
    }

    final name = await AuthService().getUsername();
    if (mounted && name != null && name != username) {
      setState(() {
        username = name;
      });
      await SharedPrefsHelper.saveUsername(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002E6D), Color(0xFF006F9E), Color(0xFF3A7BB9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5, 1.0],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Welcome, $username 🚗",
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
                          MaterialPageRoute(
                            builder: (_) => DriverDetailsPage(),
                          ),
                        );
                      },
                    ),
                    HomeCard(
                      icon: Icons.chat,
                      label: 'Chat with Driver',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatWithDriverPage(),
                          ),
                        );
                      },
                    ),
                    HomeCard(
                      icon: Icons.payment,
                      label: 'Payment',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PaymentPage(),
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
