import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/SignInPage.dart';
import 'package:flutter_application_1/auth/auth_servies.dart';
import 'package:flutter_application_1/auth/shered_pref.dart';
import 'package:flutter_application_1/auth/validators.dart';
import 'package:flutter_application_1/widget/custom_text_form.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String username = 'User';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final name = await SharedPrefsHelper.getUsername();
    if (mounted && name != null) {
      setState(() => username = name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A2A6C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002E6D), Color(0xFF006F9E), Color(0xFF3A7BB9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildProfileCard(),
            const SizedBox(height: 30),

            _buildSettingCard(
              icon: Icons.email_outlined,
              title: 'Change Email',
              onTap: _showEmailDialog,
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: _showPasswordDialog,
            ),
            const SizedBox(height: 40),

            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: const Color(0xFF1A2A6C),
            child: Text(
              username[0].toUpperCase(),
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            username,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.white, size: 26),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        final confirm = await _showConfirmDialog('Logout', 'Are you sure?');
        if (confirm == true) {
          await AuthService().signOut();
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SignInPage()),
          );
        }
      },
      icon: const Icon(Icons.logout),
      label: const Text('Logout'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<bool?> _showConfirmDialog(String title, String message) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2A6C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showEmailDialog() {
    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2A6C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Change Email', style: TextStyle(color: Colors.white)),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomFiled(
                labelText: 'Current Password',
                controller: passwordController,
                focusNode: null,
                prefixIcon: const Icon(Icons.lock, color: Color(0xFFE0E0E0)),
                validator: Validators.validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              CustomFiled(
                labelText: 'New Email',
                controller: emailController,
                focusNode: null,
                prefixIcon: const Icon(Icons.email, color: Color(0xFFE0E0E0)),
                validator: Validators.validateEmail,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

           
              final signInError = await AuthService().signIn(
                email: AuthService().currentUser!.email!,
                password: passwordController.text,
              );

              if (signInError != null) {
                _showMessage('Incorrect password', Colors.red);
                return;
              }

              final error = await AuthService().updateEmail(emailController.text.trim());
              
              if (!mounted) return;
              Navigator.pop(context);

              if (error != null) {
                _showMessage(error, Colors.red);
              } else {
                _showMessage('Email updated successfully!', Colors.green);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00FFF0)),
            child: const Text('Update', style: TextStyle(color: Color(0xFF1A2A6C))),
          ),
        ],
      ),
    );
  }

  void _showPasswordDialog() {
    final formKey = GlobalKey<FormState>();
    final currentController = TextEditingController();
    final newController = TextEditingController();
    final confirmController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2A6C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Change Password', style: TextStyle(color: Colors.white)),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomFiled(
                labelText: 'Current Password',
                controller: currentController,
                focusNode: null,
                prefixIcon: const Icon(Icons.lock, color: Color(0xFFE0E0E0)),
                validator: Validators.validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 12),
              CustomFiled(
                labelText: 'New Password',
                controller: newController,
                focusNode: null,
                prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFE0E0E0)),
                validator: Validators.validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 12),
              CustomFiled(
                labelText: 'Confirm Password',
                controller: confirmController,
                focusNode: null,
                prefixIcon: const Icon(Icons.lock_rounded, color: Color(0xFFE0E0E0)),
                validator: (value) => Validators.validatePasswordMatch(value, newController.text),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

              final error = await AuthService().updatePassword(
                currentPassword: currentController.text,
                newPassword: newController.text,
              );

              if (!mounted) return;
              Navigator.pop(context);

              if (error != null) {
                _showMessage(error, Colors.red);
              } else {
                _showMessage('Password updated successfully!', Colors.green);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00FFF0)),
            child: const Text('Update', style: TextStyle(color: Color(0xFF1A2A6C))),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}