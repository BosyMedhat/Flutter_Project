import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/settings_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> screens = [const HomePage(), const SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: screens[currentIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),

          color: Color(0xFF002E6D),

          border: Border.all(
            color: Colors.white.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        child: ClipRRect(
          // قص المحتوى ليتناسب مع الحواف الدائرية
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.cyanAccent,
            unselectedItemColor: Colors.white54,
            showSelectedLabels: true, // إظهار النص عند الاختيار
            showUnselectedLabels:
                false, // إخفاء النص عند عدم الاختيار (شكل أنظف)
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
