import 'package:flutter/material.dart';

class CarTypePage extends StatelessWidget {
  final List<Map<String, dynamic>> carTypes = [
    {
      'name': 'Sedan',
      'icon': Icons.directions_car,
      'models': ['Toyota Camry', 'Honda Accord', 'BMW 3 Series'],
    },
    {
      'name': 'SUV',
      'icon': Icons.directions_car_filled,
      'models': ['Toyota RAV4', 'Honda CR-V', 'Ford Explorer'],
    },
    {
      'name': 'Van',
      'icon': Icons.airport_shuttle,
      'models': ['Honda Odyssey', 'Toyota Sienna', 'Chrysler Pacifica'],
    },
    {
      'name': 'Electric',
      'icon': Icons.electric_car,
      'models': ['Tesla Model S', 'Nissan Leaf', 'Chevrolet Bolt'],
    },
    {
      'name': 'Luxury',
      'icon': Icons.star,
      'models': ['Mercedes-Benz S-Class', 'BMW 7 Series', 'Audi A8'],
    },
  ];

  CarTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Car Type Selection',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A2A6C), // أزرق داكن
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF002E6D), // نفس التدرج من شاشة التسجيل
              Color(0xFF006F9E),
              Color(0xFF3A7BB9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
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
                      return _buildCarOption(
                        context,
                        carTypes[index]['name'],
                        carTypes[index]['icon'],
                        carTypes[index]['models'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarOption(
    BuildContext context,
    String carType,
    IconData icon,
    List<String> models,
  ) {
    return Card(
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        leading: Icon(icon, color: const Color(0xFFE0E0E0), size: 32),
        title: Text(
          carType,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 18,
        ),
        onTap: () {
          _showCarModels(context, carType, models);
        },
      ),
    );
  }

  void _showCarModels(
    BuildContext context,
    String carType,
    List<String> models,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1C2C), // خلفية داكنة
          title: Text(
            'Models of $carType',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                models
                    .map(
                      (model) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            model,
                            style: const TextStyle(
                              color: Color(0xFFE0E0E0),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            _showSelectedCarMessage(
                              context,
                              model,
                            ); // عرض رسالة بعد اختيار السيارة
                          },
                        ),
                      ),
                    )
                    .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // إغلاق النافذة
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        );
      },
    );
  }

  // إظهار رسالة عند اختيار السيارة
  void _showSelectedCarMessage(BuildContext context, String model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1C2C), // خلفية داكنة
          title: const Text(
            'Car Selected',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'You have selected: $model', // النص باللغة الإنجليزية
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الرسالة
                Navigator.of(context).pop(); // العودة إلى الصفحة السابقة مباشرة
              },
              child: const Text('OK', style: TextStyle(color: Colors.white70)),
            ),
          ],
        );
      },
    );
  }
}
