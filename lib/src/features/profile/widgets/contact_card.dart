import 'dart:ui';

import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final String extra;
  
  const ContactCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.extra,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: color == Colors.blue.shade100 ? Colors.blue : color == Colors.green.shade100 ? Colors.green : Colors.purple),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(extra, style: TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}