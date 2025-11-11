import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Frequently Asked Questions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 14),
        Text(
          'Find answers to common questions \n about using the JIHC Lost & Found app.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 20),
        Expanded(child: FAQDropdown()),
      ],
    );
  }
}

class FAQDropdown extends StatelessWidget {
  final List<Map<String, String>> faqData = [
    {
      "question": "How to report a lost item?",
      "answer":
          "Go back and click on the 'POST' button on the navigation bar. Then, select I lost an item on the top and fill out the fields. Finally, press the button on the bottom of the page",
    },
    {
      "question": "How to report a found item?",
      "answer":
          "Go back and click on the 'POST' button on the navigation bar. Then, select I found a lost item on the top and fill out the fields. Finally, press the button on the bottom of the page",
    },
    {
      "question": "Can I edit or delete my report after submitting?",
      "answer":
          "Yes, you can mark your item as resolved and delete it in the Profile page.",
    },
    {
      "question": "How do I change the app language?",
      "answer":
          "Currently, our team is working on adding localization to the application.",
    },
  ];

  FAQDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children:
            faqData.map((faq) {
              return ExpansionTile(
                title: Text(faq["question"]!),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(faq["answer"]!),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
