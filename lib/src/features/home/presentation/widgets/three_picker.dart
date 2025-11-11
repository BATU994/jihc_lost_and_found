import 'package:flutter/material.dart';
import 'package:jihc_landf/src/core/enums/filter.dart';

class ThreePicker extends StatefulWidget {
  const ThreePicker({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  final Filter selectedFilter;
  final ValueChanged<Filter> onChanged;

  @override
  State<ThreePicker> createState() => _ThreePickerState();
}

class _ThreePickerState extends State<ThreePicker> {
  late Filter selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.selectedFilter;
  }

  void _updateFilter(Filter filter) {
    setState(() => selectedFilter = filter);
    widget.onChanged(filter); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(236, 237, 238, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildOption('All', Filter.all),
          const SizedBox(width: 3),
          _buildOption('Lost', Filter.lost),
          const SizedBox(width: 3),
          _buildOption('Found', Filter.found),
        ],
      ),
    );
  }

  Widget _buildOption(String text, Filter filter) {
    final bool isSelected = selectedFilter == filter;

    return Expanded(
      child: InkWell(
        onTap: () => _updateFilter(filter),
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromRGBO(36, 138, 255, 1)
                : Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
