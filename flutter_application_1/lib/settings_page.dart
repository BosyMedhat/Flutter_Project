import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/SignInPage.dart';
import 'package:flutter_application_1/auth/auth_servies.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  final String username;
  final VoidCallback toggleLanguage;

  const SettingsPage({
    super.key,
    required this.username,
    required this.toggleLanguage,
  });

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
        backgroundColor: const Color(0xFF1A2A6C),
        iconTheme: const IconThemeData(color: Color(0xFFE0E0E0)),
      ),
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
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text(
              '📧 Update Email',
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
            ElevatedButton(
              onPressed: widget.toggleLanguage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A2A6C),
                foregroundColor: Colors.white,
              ),
              child: const Text('Change Language'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await AuthService().signOut();
                if (!mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInPage()),
                );
              },
              icon: const Icon(Icons.logout, color: Color(0xFFE0E0E0)),
              label: const Text(
                "Logout",
                style: TextStyle(color: Color(0xFFE0E0E0)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Color(0xFFE0E0E0)),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmailChangeForm(BuildContext context) {
    final newEmailController = TextEditingController();

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
                _buildTextField(
                  'New Email',
                  Icons.email_outlined,
                  controller: newEmailController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (newEmailController.text.isEmpty) {
                  return;
                }

                final error = await AuthService().updateEmail(
                  newEmailController.text.trim(),
                );

                if (!context.mounted) return;

                Navigator.of(context).pop();

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email updated successfully')),
                  );
                }
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
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

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
                _buildPasswordTextField(
                  'Current Password',
                  Icons.lock,
                  controller: currentPasswordController,
                ),
                const SizedBox(height: 10),
                _buildPasswordTextField(
                  'New Password',
                  Icons.lock_outline,
                  controller: newPasswordController,
                ),
                const SizedBox(height: 10),
                _buildPasswordTextField(
                  'Confirm New Password',
                  Icons.lock_rounded,
                  controller: confirmPasswordController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (currentPasswordController.text.isEmpty ||
                    newPasswordController.text.isEmpty ||
                    confirmPasswordController.text.isEmpty) {
                  return;
                }

                if (newPasswordController.text != confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                  return;
                }

                final error = await AuthService().updatePassword(
                  currentPassword: currentPasswordController.text,
                  newPassword: newPasswordController.text,
                );

                if (!context.mounted) return;

                Navigator.of(context).pop();

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password updated successfully')),
                  );
                }
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

  Widget _buildTextField(
    String label,
    IconData icon, {
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.white),
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

  Widget _buildPasswordTextField(
    String label,
    IconData icon, {
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: Colors.white),
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