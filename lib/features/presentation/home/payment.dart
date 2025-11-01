import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Payment',
          style: TextStyle(color: Color(0xFF00FFF0)),
        ),
        // backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFF00FFF0)),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text(
              'Trip Fare: \$45.00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Select Payment Method:',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 20),
            _buildPaymentOption(context, Icons.credit_card, 'Credit Card'),
            _buildPaymentOption(context, Icons.money, 'Cash'),
            _buildPaymentOption(
              context,
              Icons.account_balance_wallet,
              'Wallet',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    return Card(
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00FFF0), size: 28),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white70,
          size: 16,
        ),
        onTap: () {
          // هنا مجرد UI، ممكن تضيف أي وظيفة لاحقًا
        },
      ),
    );
  }
}
