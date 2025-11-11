import 'package:flutter/material.dart';
import 'package:jihc_landf/src/core/enums/page_switch.dart';
import 'package:jihc_landf/src/features/profile/widgets/contact_page.dart';
import 'package:jihc_landf/src/features/profile/widgets/faq.dart';
import 'package:jihc_landf/src/features/profile/widgets/three_picker.dart';

class SupportFeedback extends StatefulWidget {
  SupportFeedback({super.key});

  @override
  State<SupportFeedback> createState() => _SupportFeedbackState();
}

class _SupportFeedbackState extends State<SupportFeedback> {
  PageSwitch selectedFilter = PageSwitch.faq;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Help & Support",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          ThreePickerSandF(selectedFilter: selectedFilter, onChanged: (PageSwitch filter) {
            setState(() {
              selectedFilter = filter;
            });
          }),
          SizedBox(height: 20),
          switch(selectedFilter) {
            PageSwitch.faq => Expanded(child: FAQPage()),
            PageSwitch.contact => Expanded(child: ContactPage ()),
            PageSwitch.report => Expanded(child: Center(child: Text('Report Page'))),
          },
        ],
      ),
    );
  }
}
