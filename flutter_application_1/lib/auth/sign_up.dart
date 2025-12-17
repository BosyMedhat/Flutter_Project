import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_servies.dart';
import 'package:flutter_application_1/widget/custom_text_form.dart';
import 'validators.dart';
import 'SignInPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final error = await AuthService().signUp(
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignInPage()),
      );
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'VOYAA 🚗',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE0E0E0),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomFiled(
                    labelText: 'Username',
                    controller: _usernameController,
                    focusNode: null,
                    onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
                    prefixIcon: Icon(
                      Icons.person,
                      color: const Color(0xFFE0E0E0),
                    ),
                    validator: Validators.validateUsername,
                  ),
                  const SizedBox(height: 20),

                  CustomFiled(
                    labelText: 'Email',

                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                    prefixIcon: Icon(
                      Icons.email,
                      color: const Color(0xFFE0E0E0),
                    ),
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 20),
                  CustomFiled(
                    labelText: 'password',
                    obscureText: true,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted:
                        (_) => _confirmPasswordFocusNode.requestFocus(),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: const Color(0xFFE0E0E0),
                    ),
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 20),
                  CustomFiled(
                    labelText: 'Confirm Password',
                    obscureText: true,
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocusNode,
                    onFieldSubmitted: (_) => _submitForm(),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: const Color(0xFFE0E0E0),
                    ),
                    validator:
                        (value) => Validators.validatePasswordMatch(
                          value,
                          _passwordController.text,
                        ),
                  ),

                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color(0xFF1A2A6C),
                      foregroundColor: Colors.white,
                      elevation: 5,
                    ),
                    child:
                        _isLoading
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : const Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignInPage()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
