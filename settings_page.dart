import 'package:flutter/material.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  final String username;

  const SettingsPage({super.key, required this.username});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFFE0E0E0),
          ),
        ),

        iconTheme: const IconThemeData(color: Color(0xFFE0E0E0)),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const Text(
                '🔄 Update Email',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () => _showEmailChangeForm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A2A6C),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Change Email'),
              ),
              const SizedBox(height: 30),
              const Text(
                '🔐 Update Password',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () => _showPasswordChangeForm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A2A6C),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Change Password'),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(username: widget.username),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back, color: Color(0xFFE0E0E0)),
                label: const Text(
                  "Back to Home",
                  style: TextStyle(color: Color(0xFFE0E0E0)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Color(0xFFE0E0E0)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEmailChangeForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A2A6C),
          title: const Text(
            'Change Email',
            style: TextStyle(color: Color(0xFFE0E0E0)),
          ),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Current Email', Icons.email),
                const SizedBox(height: 10),
                _buildTextField('New Email', Icons.email_outlined),
                const SizedBox(height: 10),
                _buildTextField('Confirm New Email', Icons.email_rounded),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Email updated successfully")),
                );
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Color(0xFF00FFF0)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFFE0E0E0)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPasswordChangeForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A2A6C),
          title: const Text(
            'Change Password',
            style: TextStyle(color: Color(0xFFE0E0E0)),
          ),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPasswordTextField('Current Password', Icons.lock),
                const SizedBox(height: 10),
                _buildPasswordTextField('New Password', Icons.lock_outline),
                const SizedBox(height: 10),
                _buildPasswordTextField(
                  'Confirm New Password',
                  Icons.lock_rounded,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password updated successfully"),
                  ),
                );
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Color(0xFF00FFF0)),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFFE0E0E0)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: const Color(0xFFE0E0E0)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(String label, IconData icon) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,

        labelStyle: const TextStyle(color: Colors.white60),
        prefixIcon: Icon(icon, color: const Color(0xFFE0E0E0)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
