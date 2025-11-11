import 'package:flutter/material.dart';
import 'package:jihc_landf/src/features/profile/widgets/contact_card.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Get in Touch",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Need help? Contact our support team\nand we'll get back to you soon.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            ContactCard(
              color: Colors.blue.shade100,
              icon: Icons.email,
              title: "Email Support",
              subtitle: "support@jihc.edu.kz",
              extra: "We typically respond within 24 hours",
            ),
            SizedBox(height: 12),
            ContactCard(
              color: Colors.green.shade100,
              icon: Icons.phone,
              title: "Phone Support",
              subtitle: "+7 708 583 14 91",
              extra: "Mon-Fri, 9:00 AM - 6:00 PM",
            ),
            SizedBox(height: 12),
            ContactCard(
              color: Colors.purple.shade100,
              icon: Icons.location_on,
              title: "Visit Us",
              subtitle: "IT Department, JIHC",
              extra: "Building B, Room 205",
            ),
          ],
        ),
      ),
    );
  }
}
