import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay with Credit Card'),
        backgroundColor: const Color(0xFF002E6D),
        foregroundColor: Color(0xFF00FFF0),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002E6D), Color(0xFF006F9E), Color(0xFF3A7BB9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildCreditCard(),
              const SizedBox(height: 30),
              _buildInputField('Card Holder Name'),
              const SizedBox(height: 15),
              _buildCardNumberField(),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: _buildExpiryDateField()),
                  const SizedBox(width: 15),
                  Expanded(child: _buildCvvField()),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment Successful')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFF0),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Pay \$45.00'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.indigo.shade700,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'VISA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Text(
            '**** **** **** 1234',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'John Doe',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 5),
          Text('Exp: 12/26', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildInputField(String label) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00FFF0)),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white12,
        filled: true,
      ),
      keyboardType:
          label.contains('Number') || label.contains('CVV')
              ? TextInputType.number
              : TextInputType.text,
    );
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Card Number',
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00FFF0)),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white12,
        filled: true,
      ),
      keyboardType: TextInputType.number,
      maxLength: 16,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter card number';
        }
        if (value.length != 16) {
          return 'Card number must be 16 digits';
        }
        return null;
      },
    );
  }

  Widget _buildExpiryDateField() {
    return TextFormField(
      controller: _expiryDateController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Expiry Date (MM/YY)',
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00FFF0)),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white12,
        filled: true,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(5), // Limit to MM/YY format
        TextInputFormatter.withFunction((oldValue, newValue) {
          String text = newValue.text;

          // Add '/' after two digits
          if (text.length == 2 && !text.contains('/')) {
            text = '${text.substring(0, 2)}/';
          }

          // Ensure the '/' remains in place
          if (text.length > 2 && text[2] != '/') {
            text = '${text.substring(0, 2)}/${text.substring(2)}';
          }

          return TextEditingValue(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          );
        }),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter expiry date';
        }
        if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
          return 'Enter a valid expiry date (MM/YY)';
        }
        return null;
      },
    );
  }

  Widget _buildCvvField() {
    return TextFormField(
      controller: _cvvController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'CVV',
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00FFF0)),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white12,
        filled: true,
      ),
      keyboardType: TextInputType.number,
      maxLength: 3,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter CVV';
        }
        if (value.length != 3) {
          return 'CVV must be 3 digits';
        }
        return null;
      },
    );
  }
}
