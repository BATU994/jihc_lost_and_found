import 'package:flutter/material.dart';

class BuildDropdown extends StatelessWidget {
  const BuildDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
  });
  final String title;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? value;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black12),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                hint ?? '',
                style: const TextStyle(color: Colors.black54),
              ),
              isExpanded: true,
              items:
                  items
                      .map(
                        (e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
